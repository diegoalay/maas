<script>
export default {
    props: {
        serviceSchedule: {
            type: Array,
            required: true
        },

        shiftId: {
            required: true
        },

        shiftAvailables: {
            type: Array,
            required: true
        },

        employees: {
            type: Array,
            required: true
        }
    },

    data(){
        return {
            availables: [],
            schedule: [],
            fields: [{
                key: 'time_range',
                label: 'Horario'
            }],
            data: [],
            assignedUsers: []
        }
    },

    mounted() {
        this.setFields()
    },

    methods: {
        submitUserAvailable(user_id, hour_id, day_id, event){
            const find = this.getAvailableValue(user_id, hour_id, day_id)

            this.setScheduleColors(hour_id, day_id, event ? true : this.hasAssignedUsers(hour_id, day_id))

            if (find.id !== -1) {
                this.putForm(find.id, event)
            } else {
                this.postForm(user_id, hour_id, day_id)
            }
        },

        postForm(user_id, hour_id, day_id){
            const url = `/shifts/${this.shiftId}/availables.json`
            const form = {
                shift_available: {
                    user_id: user_id,
                    hour_id: hour_id,
                    day_id: day_id,
                    status: true
                }
            }

            this.http.post(url, form).then(result => {
                if (result.successful) {
                    this.$toast.success('Disponibilidad actualizada exitosamente.')
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },
        putForm(availableId, status){
            const url = `/shifts/${this.shiftId}/availables/${availableId}.json`
            const form = {
                shift_available: {
                    status
                }
            }

            this.http.put(url, form).then(result => {
                if (result.successful) {
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
        },

        getAvailableValue(user_id, hour_id, day_id){

            const find = this.availables.find(e =>
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
                if(this.getAvailableValue(user.id, hour_id, day_id).status) {
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
        }
    },

    watch: {
        serviceSchedule(value){
            this.schedule = value
        },

        shiftAvailables(value){
            this.availables = value

            setTimeout(() => {
                for(let available of this.availables) {
                    if (available.status) {
                        this.setScheduleColors(available.hour_id, available.day_id)
                    }
                }
            }, 500);
        }
    }
}
</script>

<template>
    <div class="shift-availables">
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
                            v-for="(time, timeIndex) in getDaySchedule(index)"
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
                                    @change="submitUserAvailable(employee.id, time.hour_id, index, $event)"
                                    v-model="getAvailableValue(employee.id, time.hour_id, index)['status']"
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