<script>
export default {
    components :{},
    props: {
        service: {
            required: true,
            type: Object
        }
    },
    data() {
        return {
            sale: {},
            days: [],
            options: {
                hours: []
            }
        }
    },
    mounted() {
        if (this.service.id) { // set hours saved
            this.setServiceSchedule()
        } else {
            this.setDefaultSchedule()
        }

        this.$set(this.options, 'hours', this.hours())
    },
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
                    this.$toast.success('service creado exitosamente.')
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
                    this.$toast.success('servicio actualizado exitosamente.')
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },

        setServiceSchedule(){
            for (let key in this.service.schedule) {
                this.days.push({
                    text: this.tools.getDayName(key),
                    status: this.service.schedule[key].status,
                    start_at: this.service.schedule[key].start_at,
                    end_at: this.service.schedule[key].end_at,
                })
            }
        },

        setDefaultSchedule(){
            this.days = [{
                text: this.tools.getDayName(0),
                start_at: 19,
                end_at: 24,
                status: true
            },{
                text: this.tools.getDayName(1),
                start_at: 19,
                end_at: 24,
                status: true
            },{
                text: this.tools.getDayName(2),
                start_at: 19,
                end_at: 24,
                status: true
            },{
                text: this.tools.getDayName(3),
                start_at: 19,
                end_at: 24,
                status: true
            },{
                text: this.tools.getDayName(4),
                start_at: 19,
                end_at: 24,
                status: true
            },{
                text: this.tools.getDayName(5),
                start_at: 10,
                end_at: 24,
                status: true
            },{
                text: this.tools.getDayName(6),
                start_at: 10,
                end_at: 24,
                status: true
            }]
        },

        startAtHours(){
            return this.options.hours.filter((e) => e.value !== 24)
        },

        endAtHours(){
            let options = this.options.hours.filter((e) => e.value !== 0)
            options[23].text = '00:00'

            return options
        },

        hours(){
            let hours = []
            for (let i=0; i<=24; i++){
                let text = `${i}:00`

                hours.push({
                    value: i,
                    text
                })
            }

            return hours
        },

        validateEndAt(index){
            const day = this.days[index]

            if (day.end_at <= day.start_at) {
                this.$set(this.days[index], 'end_at', day.start_at + 1)

                this.$toast.warning(`La hora de inicio del día ${day.text} debe ser menor a la hora final.`, {
                    timeout: 3000,
                })
            }
        }
    },
    watch: {
        'days': {
            immediate: true,
            handler(value){
                if (value.length > 0) {
                    this.$emit("schedule", value)
                }
            },
            deep: true
        }
    }
}
</script>

<template>
    <b-form @submit.prevent="onSubmit">
        <b-card>
            <b-card-body>
                <b-form-group v-for="(day, index) in days" :key="index">
                    <b-row>
                        <b-col md="3" sm="12">
                            <b-form-checkbox v-model="days[index].status" button-variant="danger" switch>
                                <b>{{ day.text }} </b>
                            </b-form-checkbox>
                        </b-col>
                        <b-col md="4" sm="6">
                            <b-input-group>
                                <template #prepend>
                                    <b-input-group-text >Desde</b-input-group-text>
                                </template>
                                <b-form-select
                                    @change="validateEndAt(index)"
                                    :disabled="!days[index].status"
                                    v-model="days[index].start_at"
                                    :options="startAtHours()"
                                >
                                </b-form-select>
                            </b-input-group>
                        </b-col>
                        <b-col md="4" sm="6">
                            <b-input-group>
                                <template #prepend>
                                    <b-input-group-text >Hasta</b-input-group-text>
                                </template>
                                <b-form-select
                                    @change="validateEndAt(index)"
                                    :disabled="!days[index].status"
                                    v-model="days[index].end_at"
                                    :options="endAtHours()"
                                >
                                </b-form-select>
                            </b-input-group>
                        </b-col>
                    </b-row>
                </b-form-group>
            </b-card-body>
        </b-card>
    </b-form>
</template>