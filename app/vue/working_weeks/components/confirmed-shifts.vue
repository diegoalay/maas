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

        shiftConfirmations: {
            type: Array,
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
            confirmations: [],
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
        // this.setFields()
    },

    methods: {
        setFields(){
            for (let key in this.employees) {
                let user = this.employees[key]

                this.fields.push({
                    label: user.full_name,
                    key: "user_" + user.id,
                })
            }
        },
    },

    watch: {
        serviceSchedule(value){
            this.schedule = value
        },

        shiftConfirmations(value){
            this.confirmations = value
        }
    }
}
</script>

<template>
    <div class="shift-confirmations">
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
                            <b-th>
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
                                v-bind:style="{backgroundColor: '#FFFFFF'}"
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