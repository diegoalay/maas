<script type="text/javascript">
    import componentShiftAvailables from '../components/shift-availables.vue'
    import componentShiftConfirmations from '../components/shift-confirmations.vue'

    export default {
        components: {
            'component-shift-availables': componentShiftAvailables,
            'component-shift-confirmations': componentShiftConfirmations,
        },
        data() {
            return {
                serviceId: null,
                weekId: null,
                shiftId: null,
                serviceSchedule: [],
                options: {
                    services: [],
                    weeks: []
                },
                loading: false,
                currentSchedule: [],
                shiftConfirmations: [],
                shiftAvailables: [],
                viewMode: 'availables'
            }
        },
        mounted() {
            this.getOptions()
        },
        methods: {
            getShifts(){

            },

            getOptions(){
                const url = `/shifts/options.json`

                this.http.get(url).then(result => {
                    if (result.successful) {
                        this.options = result.data
                    } else {
                        this.$toast.error(result.error.message)
                    }
                }).catch(error => {
                    console.log(error)
                })
            },

            getAvailableWeeks(){
                const url = `/services/${this.serviceId}/available_shifts.json`

                this.http.get(url).then(result => {
                    if (result.successful) {
                        this.$set(this.options, 'weeks', result.data)

                        if (!this.weekId) {
                            this.weekId = this.tools.getWeek()
                            this.weekChange(this.weekId)
                        }
                    } else {
                        this.$toast.error(result.error.message)
                    }
                }).catch(error => {
                    console.log(error)
                })
            },

            shiftChange(){
                this.setSchedule()
                this.getAvailableWeeks()
            },

            weekChange(weekId){
                const week = this.options.weeks.find(e => e.value === weekId)
                this.shiftId = week.shift_id
            },

            setSchedule(){
                this.serviceSchedule = this.options.services
                .find((e) => e.value === this.serviceId).schedule
            },

            viewShiftAvailables(){
                return (this.viewMode === 'availables')
            },

            viewShiftConfirmations(){
                return (this.viewMode === 'confirmations')
            },

            getTitle(){
                if (this.viewShiftAvailables()) {
                    'Ver Detalles'
                } else {
                    'Editar disponibilidad'
                }
            },

            switchViewType(){
                if (this.viewShiftAvailables()) {
                    this.viewMode = 'confirmations'
                } else {
                    this.viewMode = 'availables'
                }
            },

            getDaySchedule(day){
                let hours = []
                const day_info = this.schedule[day]

                for(let i = day_info.start_at; i < day_info.end_at; i++){
                    hours.push({
                        hour_id: i,
                        text: `${i}:00 - ${i === 23 ? '00': i+1}:00`
                    })
                }

                return hours
            }
        }
    }
</script>

<template>
    <section>
        <component-header-list
            :title="`Semana actual ${tools.getWeek()}`"
            :loading="loading"
            @reloadList="getShifts()"
        >
            <slot name="buttons">
                <b-button variant="outline-dark" class="mb-2" @click="switchViewType()">
                    {{ getTitle() }}
                </b-button>
            </slot>
        </component-header-list>
        <b-card>
            <b-card-body>
                <b-row>
                    <b-col md="7" sm="12">
                        <b-input-group>
                            <template #prepend>
                                <b-input-group-text> Servicio </b-input-group-text>
                            </template>
                            <b-form-select
                                @change="shiftChange()"
                                v-model="serviceId"
                                :options="options.services"
                            >
                                <template #first>
                                    <b-form-select-option :value="null"> Seleccione un servicio  </b-form-select-option>
                                </template>
                            </b-form-select>
                        </b-input-group>
                    </b-col>
                    <b-col md="5" sm="6" v-if="serviceId">
                        <b-input-group>
                            <template #prepend>
                                <b-input-group-text> Semana  </b-input-group-text>
                            </template>
                            <b-form-select
                                @change="weekChange"
                                v-model="weekId"
                                :options="options.weeks"
                            >
                                <template #first>
                                    <b-form-select-option :value="null"> Seleccione una semana  </b-form-select-option>
                                </template>
                            </b-form-select>
                        </b-input-group>
                    </b-col>
                </b-row>

                <component-shift-availables
                    v-if="viewShiftAvailables() && serviceId"
                    :get-day-schedule="getDaySchedule"
                    :service-schedule="serviceSchedule"
                    :employees="options.employees"
                    :shift-id="shiftId"
                >
                </component-shift-availables>

                <component-shift-confirmations
                    v-if="viewShiftConfirmations() && serviceId"
                    :get-day-schedule="getDaySchedule"
                    :service-schedule="serviceSchedule"
                    :employees="options.employees"
                    :shift-id="shiftId"
                >
                </component-shift-confirmations>
            </b-card-body>
        </b-card>
    </section>
</template>