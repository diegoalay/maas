<script>
export default {
    props: {},
    components: {},
    data() {
        return {
            user: {}
        }
    },
    mounted() {
        this.getData()
    },
    methods: {
        getData(){
            const url = 'profile.json'

            this.http.get(url).then(result => {
                if (result.successful) {
                    this.user = result.data
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },

        onSubmit(){
            const url = 'profile.json'

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
    <section>
        <component-header-form
            title="Mi perfil"
            :show-buttons="false"
        >
        </component-header-form>
        <b-form @submit.prevent="onSubmit">
            <b-card>
                <b-card-body>
                    <b-row>
                        <b-col md="6" sm="6">
                            <b-form-group>
                                <template #label>
                                    Primer Nombre <sup class="text-danger">*</sup>
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
                        <b-col md="6" sm="6">
                            <b-form-group>
                                <template #label>
                                    Primer apellido <sup class="text-danger">*</sup>
                                </template>

                                <b-form-input
                                    v-model="user.last_name"
                                    type="text"
                                    placeholder=""
                                >
                                </b-form-input>
                            </b-form-group>
                        </b-col>
                    </b-row>

                    <b-form-group>
                        <label> E-Mail <sup class="text-danger">*</sup> </label>

                        <b-form-input
                            v-model="user.email"
                            type="text"
                            placeholder=""
                            required
                            disabled
                            readonly
                        >
                        </b-form-input>
                    </b-form-group>

                    <b-button type="submit" variant="primary">Guardar</b-button>
                </b-card-body>
            </b-card>
        </b-form>
    </section>
</template>