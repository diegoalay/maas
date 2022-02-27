<script>
import componentSchedule from '../components/schedule.vue'

export default {
    components : {
        'component-schedule': componentSchedule
    },
    props: {
        service: {
            required: true,
            type: Object
        }
    },
    data() {
        return {

        }
    },
    mounted() {},
    methods: {
        onSubmit(){
            if (this.service.id) {
                this.putForm()
            } else {
                this.postForm()
            }
        },
        postForm(){
            const url = `/services.json`

            this.http.post(url, {service: this.service}).then(result => {
                if (result.successful) {
                    this.$toast.success('Servicio creado exitosamente.')
                    this.$router.push(`/services/${result.data.id}`)
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },
        putForm(){
            const url = `/services/${this.service.id}`

            this.http.put(url, {service: this.service}).then(result => {
                if (result.successful) {
                    this.$toast.success('Servicio actualizado exitosamente.')
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },
        serviceSchedule(value){
            this.$set(this.service, 'schedule', value)
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
                                v-model="service.name"
                                type="text"
                                placeholder=""
                                required
                            >
                            </b-form-input>
                        </b-form-group>
                    </b-col>
                </b-row>

                <hr>
                <div class="text-center">
                    <h5> <b> Horarios </b> </h5>
                </div>

                <component-schedule @schedule="serviceSchedule" :service="service"></component-schedule>

                <div class="text-right" v-if="tools.isAdmin()">
                    <b-button type="submit" variant="primary">Guardar</b-button>
                </div>
            </b-card-body>
        </b-card>
    </b-form>
</template>