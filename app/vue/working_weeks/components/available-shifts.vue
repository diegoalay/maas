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
            available_shifts: [],
            schedule: [],
            fields: [{
                key: 'time_range',
                label: 'Horario'
            }],
            data: [],
            assignedUsers: [],
            hoursByUser: {}
        }
    },

    mounted() {},

    methods: {
        clearData(){
            this.available_shifts = []
            this.fields = [{
                key: 'time_range',
                label: 'Horario'
            }],
            this.data = []
            this.assignedUsers = []
            this.hoursByUser = {}
        },

        submitAvailableShift(user_id, hour_id, day_id, event){
            const find = this.getAvailableShiftValue(user_id, hour_id, day_id)

            if (find.id !== -1) {
                this.putForm(find.id, event, user_id, hour_id, day_id)
            } else {
                this.postForm(user_id, hour_id, day_id)
            }
        },

        postForm(user_id, hour_id, day_id){
            const url = `/working_weeks/${this.workingWeekId}/available_shifts.json`
            const form = {
                available_shift: {
                    user_id: user_id,
                    hour_id: hour_id,
                    day_id: day_id,
                    status: true
                }
            }

            this.http.post(url, form).then(result => {
                if (result.successful) {
                    this.setScheduleColors(hour_id, day_id, true)
                    this.sethoursByUser(user_id)

                    this.available_shifts.push({
                        id: result.data.id,
                        user_id: user_id,
                        hour_id: hour_id,
                        day_id: day_id,
                        status: true
                    })

                    this.$toast.success('Disponibilidad actualizada exitosamente.')
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },

        putForm(availableId, status, user_id, hour_id, day_id){
            const url = `/working_weeks/${this.workingWeekId}/available_shifts/${availableId}.json`
            const form = {
                available_shift: {
                    status
                }
            }

            this.http.put(url, form).then(result => {
                if (result.successful) {
                    this.setScheduleColors(hour_id, day_id, this.hasAssignedUsers(hour_id, day_id))
                    this.sethoursByUser(user_id, status ? 1 : -1)

                    this.$toast.success('Disponibilidad actualizada exitosamente.')
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
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

        getAvailableShiftValue(user_id, hour_id, day_id){

            const find = this.available_shifts.find(e =>
                e.user_id === user_id &&
                e.hour_id === hour_id &&
                e.day_id === day_id
            )

            if (find) {
                return find
            } else {
                return { id: -1, status: false }
            }
        },

        hasAssignedUsers(hour_id, day_id) {
            let assigned = false
            for (let user of this.employees) {
                if(this.getAvailableShiftValue(user.id, hour_id, day_id).status) {
                    assigned = assigned || true
                }
            }

            return assigned
        },

        setScheduleColors(hour_id, day_id, status = true){
            const index = this.assignedUsers.findIndex(e =>
                e.hour_id == hour_id &&
                e.day_id === day_id
            )

            if (index === -1) {
                this.assignedUsers.push({
                    hour_id: hour_id,
                    day_id: day_id,
                    status: status,
                })
            } else {
                this.$set(this.assignedUsers, index, {
                    ...this.assignedUsers[index],
                    status: status
                })
            }
        },

        countUserHours(user_id){
            const total = this.hoursByUser[user_id]

            return total ? total : 0
        },

        sethoursByUser(user_id, value = 1) {
            if (!this.hoursByUser[user_id]) this.hoursByUser[user_id] = 0

            this.hoursByUser[user_id] += value
        },

        async getData(){
            this.available_shifts = await this.getAvailableShiftsData()

            for(let available of this.available_shifts) {
                if (available.status) {
                    this.setScheduleColors(available.hour_id, available.day_id)
                    this.sethoursByUser(available.user_id)
                }
            }
        },

        async getAvailableShiftsData(key){
            return new Promise(async (resolve, reject) => {
                const url = `working_weeks/${this.workingWeekId}/available_shifts.json`
                await this.http.get(url).then(result => {
                    resolve(result.successful ? result.data : {})
                }).catch(error => {

                    reject()
                    console.log(error)
                })
            })
        },
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
    <div class="available-shifts">
        <b-row class="text-cent">
            <b-col>
                <b-table-simple
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
                :md="`${employees.length}`"
                sm="12"
                v-for="(day, index) in schedule" :key="index"
            >

                <b> {{ tools.getDayName(index) }} </b>
                <b-table-simple
                    v-if="day.status"
                    :bordered="true"
                    :small="true"
                    :fixed="true"
                >
                    <b-thead>
                        <b-tr>
                            <b-th >Horario</b-th>
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
                        <b-tr
                            v-for="(time, timeIndex) in getDaySchedule(index, schedule)"
                            :key="index + '-' + timeIndex"
                        >
                            <b-td
                                class="text-center"
                                v-bind:style="{backgroundColor: assignedUsers.find((e) =>
                                        e.hour_id === time.hour_id &&
                                        e.day_id === index &&
                                        e.status === true
                                    ) ? '#a3d6b1' : '#d9a3a0'
                                }"
                            >
                                {{ time.text }}
                            </b-td>
                            <b-td
                                v-for="employee in employees"
                                :key="employee.id"
                                v-bind:class="'text-center'"
                            >
                                <b-form-checkbox
                                    @change="submitAvailableShift(employee.id, time.hour_id, index, $event)"
                                    v-model="getAvailableShiftValue(employee.id, time.hour_id, index)['status']"
                                >
                                </b-form-checkbox>
                            </b-td>
                        </b-tr>
                    </b-tbody>
                </b-table-simple>
            </b-col>
        </b-row>
    </div>
</template>