<script type="text/javascript">
    import componentAvailableShift from '../components/available-shifts.vue'
    import componentConfirmedShift from '../components/confirmed-shifts.vue'

    export default {
        components: {
            'component-available-shifts': componentAvailableShift,
            'component-confirmed-shifts': componentConfirmedShift,
        },
        data() {
            return {
                serviceId: null,
                weekNumber: null,
                WorkingWeekId: null,
                serviceSchedule: [],
                options: {
                    employees: [],
                    services: [],
                    weeks: []
                },
                loading: false,
                currentSchedule: [],
                shiftConfirmations: [],
                shiftAvailables: [],
                viewMode: 'available_shifts'
            }
        },
        mounted() {
            this.getOptions()
        },
        methods: {
            getWorkingWeeks(){

            },

            getOptions(){
                const url = `/working_weeks/options.json`

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

                        if (!this.weekNumber) {
                            this.weekNumber = this.tools.getWeekNumber()
                            this.weekChange(this.weekNumber)
                        }
                    } else {
                        this.$toast.error(result.error.message)
                    }
                }).catch(error => {x
                    console.log(error)
                })
            },

            serviceChange(){
                this.setSchedule()
                this.getAvailableWeeks()
            },

            weekChange(weekNumber){
                const week = this.options.weeks.find(e => e.value === weekNumber)
                this.WorkingWeekId = week.shift_id
            },

            setSchedule(){
                this.serviceSchedule = this.options.services
                .find((e) => e.value === this.serviceId).schedule
            },

            viewAvailableShifts(){
                return (this.viewMode === 'available_shifts')
            },

            viewConfirmedShifts(){
                return (this.viewMode === 'confirmed_shifts')
            },

            getTitle(){
                if (this.viewAvailableShifts()) {
                    return 'Ver Detalles'
                } else {
                    return 'Editar disponibilidad'
                }
            },

            switchViewType(){
                if (this.viewAvailableShifts()) {
                    this.viewMode = 'confirmed_shifts'
                } else {
                    this.viewMode = 'available_shifts'
                }
            },

            getDaySchedule(day, schedule){
                let hours = []
                const day_info = schedule[day]

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
            :title="`Semana actual ${tools.getWeekNumber()}`"
            :loading="loading"
            @reloadList="getWorkingWeeks()"
        >
            <slot name="buttons">
                <b-button
                    :variant="viewAvailableShifts() ? 'outline-dark' : 'outline-success'"
                    class="mb-2"
                    @click="switchViewType()"
                >
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
                                @change="serviceChange"
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
                                v-model="weekNumber"
                                :options="options.weeks"
                            >
                                <template #first>
                                    <b-form-select-option :value="null"> Seleccione una semana  </b-form-select-option>
                                </template>
                            </b-form-select>
                        </b-input-group>
                    </b-col>
                </b-row>

                <component-available-shifts
                    v-show="viewAvailableShifts() && serviceId"
                    :get-day-schedule="getDaySchedule"
                    :service-schedule="serviceSchedule"
                    :employees="options.employees"
                    :working-week-id="WorkingWeekId"
                >
                </component-available-shifts>

                <component-confirmed-shifts
                    v-show="viewConfirmedShifts() && serviceId"
                    :get-day-schedule="getDaySchedule"
                    :service-schedule="serviceSchedule"
                    :employees="options.employees"
                    :working-week-id="WorkingWeekId"
                >
                </component-confirmed-shifts>
            </b-card-body>
        </b-card>
    </section>
</template>