<script>
export default {
    components :{},
    props: {
        employee: {
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
            if (this.employee.id) {
                this.putForm()
            } else {
                this.postForm()
            }
        },
        postForm(){
            const url = `/employees.json`

            this.http.post(url, {employee: this.employee}).then(result => {
                if (result.successful) {
                    this.$toast.success('Employee created successfully.')
                    this.$router.push(`/employees/${result.data.id}`)
                } else {
                    this.$toast.error(result.error.message)
                }
            }).catch(error => {
                console.log(error)
            })
        },
        putForm(){
            const url = `/employees/${this.employee.id}`

            this.http.put(url, {employee: this.employee}).then(result => {
                if (result.successful) {
                    this.$toast.success('Employee updated successfully.')
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
    <b-form @submit.prevent="onSubmit">
        <b-card>
            <b-card-body>
                <b-row>
                    <b-col sm="12">
                        <b-form-group>
                            <template #label>
                                First Name <sup class="text-danger">*</sup>
                            </template>

                            <b-form-input
                                v-model="employee.first_name"
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
                                Last Name <sup class="text-danger">*</sup>
                            </template>

                            <b-form-input
                                v-model="employee.last_name"
                                type="text"
                                placeholder=""
                                required
                            >
                            </b-form-input>
                        </b-form-group>
                    </b-col>

                    <b-col sm="12">
                        <b-form-group>
                            <template #label> DPI </template>

                            <b-form-input
                                v-model="employee.identity_document_number"
                                type="text"
                                placeholder=""
                            >
                            </b-form-input>
                        </b-form-group>
                    </b-col>
                </b-row>

                <b-button type="submit" variant="primary">Guardar</b-button>
            </b-card-body>
        </b-card>
    </b-form>
</template>