<script>
export default {
    props: {
        serviceSchedule: {
            type: Array,
            required: true
        },

        workingWeekId: {
            required: true
        },

        employees: {
            type: Array,
            required: true
        },

        getDaySchedule: {
            type: Function,
            required: true
        }
    },

    data(){
        return {
            confirmed_shifts: [],
            schedule: [],
            fields: [{
                key: 'time_range',
                label: 'Horario'
            }],
            data: [],
            hoursByUser: {},
            loading: false
        }
    },

    mounted() {},

    methods: {
        clearData(){
            this.confirmed_shifts = []
            this.fields = [{
                key: 'time_range',
                label: 'Horario'
            }],
            this.data = []
            this.hoursByUser = {}
        },

        setFields(){
            for (let key in this.employees) {
                let user = this.employees[key]

                this.fields.push({
                    label: user.full_name,
                    key: "user_" + user.id,
                })
            }
        },

        getUserAssigned(hour_id, day_id){

            const find = this.confirmed_shifts.find(e =>
                e.hour_id === hour_id &&
                e.day_id === day_id
            )

            if (find !== -1) {
                this.employees.find(e => e.id === find.user_id)
            } else {
                return {
                    id: null
                }
            }
        },


        countUserHours(user_id){
            const total = this.hoursByUser[user_id]

            return total ? total : 0
        },

        sethoursByUser(user_id, value = 1) {
            if (!this.hoursByUser[`${user_id}`]) this.hoursByUser[`${user_id}`] = 0

            this.hoursByUser[`${user_id}`] = value + this.hoursByUser[`${user_id}`]
        },

        async getData(){
            this.confirmed_shifts = await this.getConfirmedShiftsData()
            this.loading = true

            for ( let index in this.schedule) {
                let day_info = this.schedule[index]

                console.log(day_info)

                if (day_info.status) {
                    this.data.push({ day_id: day_info.day_id, details: []})

                    for(let time of this.getDaySchedule(index, this.schedule)) {
                        let user = this.confirmed_shifts.find(e => e.hour_id === time.hour_id && e.day_id === day_info.day_id)

                        if (user) {
                            this.data[index].details.push({
                                text: time.text,
                                user_id: user.id,
                                user_color: user.color,
                                user_full_name: user.full_name
                            })

                            if (!this.hoursByUser[user_id]) this.hoursByUser[user_id] = 0
                            this.hoursByUser[user_id] += value
                        } else {
                           this.data[index].details.push({
                                user_id: null,
                                text: time.text
                            })
                        }
                    }
                }
            }

            this.loading = false
        },

        async getConfirmedShiftsData(){
            return new Promise(async (resolve, reject) => {
                const url = `working_weeks/${this.workingWeekId}/confirmed_shifts.json`
                await this.http.get(url).then(result => {
                    resolve(result.successful ? result.data : {})
                }).catch(error => {

                    reject()
                    console.log(error)
                })
            })
        }
    },

    watch: {
        workingWeekId: {
            handler() {
                this.clearData()
                this.setFields()
                this.getData()
            },
            inmediate: true
        },

        serviceSchedule(value){
            this.schedule = value
        }
    }
}
</script>

<template>
    <div class="confirmed-shifts">
        <b-row class="text-center">
            <b-col>
                <b-table-simple
                    v-if="!loading"
                    :bordered="true"
                    :small="true"
                    :fixed="true"
                >
                    <b-thead>
                        <b-tr>
                            <b-th >Empleado</b-th>
                            <b-th
                                v-for="employee in employees"
                                :key="employee.id"
                                v-bind:style="{ backgroundColor: employee.color }"
                            >
                                {{ employee.full_name }}
                            </b-th>
                        </b-tr>
                    </b-thead>
                    <b-tbody>
                        <b-tr>
                            <b-td> Horas disponibles </b-td>
                            <b-td
                                v-for="employee in employees"
                                :key="employee.id"
                            >
                                {{ countUserHours(employee.id) }}
                            </b-td>
                        </b-tr>
                    </b-tbody>
                </b-table-simple>
            </b-col>
        </b-row>

        <hr>

        <b-row>
            <b-col
                sm="12"
                md="2"
                v-for="(info, index) in data" :key="info.day_id"
            >
                <b> {{ tools.getDayName(index) }} </b>
                <b-table-simple
                    :bordered="true"
                    :small="true"
                    :fixed="true"
                >
                    <b-thead>
                        <b-tr>
                            <b-th >Horario</b-th>
                            <b-th >Empleado</b-th>
                        </b-tr>
                    </b-thead>
                    <b-tbody>
                        <b-tr
                            v-for="(time, index_time) in info.details"
                            :key="info.day_id + '-' + index_time"
                        >
                            <b-td
                                class="text-center"
                                v-bind:style="{backgroundColor: time.user_id ? '#a3d6b1' : '#d9a3a0' }"
                            >
                                {{ time.text }}
                            </b-td>
                            <b-td
                                v-if="time.user_id"
                                class="text-center"
                                v-bind:style="{ backgroundColor: time.user_color }"
                            >
                                {{ time.user_full_name }}
                            </b-td>
                            <b-td v-else class="text-center">
                                <font-awesome-icon icon="triangle-exclamation" />
                            </b-td>
                        </b-tr>
                    </b-tbody>
                </b-table-simple>
            </b-col>
        </b-row>
    </div>
</template>