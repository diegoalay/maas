<script>
export default {
    components :{},
    props: {
        user: {
            required: true,
            type: Object
        }
    },
    data() {
        return {

        }
    },
    mounted() {
    },
    methods: {
        onSubmit(){
            if (this.user.id) {
                this.putForm()
            } else {
                this.postForm()
            }
        },
        postForm(){
            const url = `/users.json`

            this.http.post(url, {user: this.user}).then(result => {
                if (result.successful) {
                    this.$toast.success('Usuario creado exitosamente.')

                    this.$router.push(`/users/${result.data.id}`)
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },
        putForm(){
            const url = `/users/${this.user.id}`

            this.http.put(url, {user: this.user}).then(result => {
                if (result.successful) {
                    this.$toast.success('Usuario actualizado exitosamente.')
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        }
    }
}
</script>

<template>
    <b-form @submit.prevent="onSubmit">
        <b-card>
            <b-card-body>
                <b-row>
                    <b-col sm="12">
                        <b-form-group>
                            <template #label>
                                Nombre <sup class="text-danger">*</sup>
                            </template>

                            <b-form-input
                                v-model="user.first_name"
                                type="text"
                                placeholder=""
                                required
                            >
                            </b-form-input>
                        </b-form-group>
                    </b-col>

                    <b-col sm="12">
                        <b-form-group>
                            <template #label>
                                Apellido <sup class="text-danger">*</sup>
                            </template>

                            <b-form-input
                                v-model="user.last_name"
                                type="text"
                                placeholder=""
                                required
                            >
                            </b-form-input>
                        </b-form-group>
                    </b-col>

                    <b-col sm="12">
                        <b-form-group>
                            <template #label> DPI </template>

                            <b-form-input
                                v-model="user.identity_document_number"
                                type="text"
                                placeholder=""
                            >
                            </b-form-input>
                        </b-form-group>
                    </b-col>
                </b-row>

                <b-button type="submit" variant="primary">Guardar</b-button>
            </b-card-body>
        </b-card>
    </b-form>
</template>