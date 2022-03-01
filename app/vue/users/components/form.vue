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
        },

        updateColor(){

        }
    },

    watch: {
        'user.color'(value){
            console.log(value)
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
                            <template #label> Color </template>

                            <color-picker
                                @input="updateColor"
                                v-model="user.color"
                                :preset-colors="[
                                    '#f00', '#00ff00', '#00ff0055', 'rgb(201, 76, 76)', 'rgba(0,0,255,1)', 'hsl(89, 43%, 51%)', 'hsla(89, 43%, 51%, 0.6)'
                                ]"
                            >
                            </color-picker>
                        </b-form-group>
                    </b-col>
                </b-row>

                <b-button type="submit" variant="primary">Guardar</b-button>
            </b-card-body>
        </b-card>
    </b-form>
</template>