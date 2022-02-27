<script type="text/javascript">
    export default {
        components: {

        },
        data() {
            return {
                data: [],
                fields: [{
                    label: 'Fecha de cración',
                    key: 'created_at',
                    sortable: true
                },{
                    label: 'Nombre',
                    key: 'full_name',
                    sortable: true
                },{
                    label: 'DPI',
                    key: 'identity_document_number',
                    sortable: true
                },{
                    label: 'Usuario creador',
                    key: 'user_creator_name',
                    sortable: true
                },{
                    label: '',
                    key: 'actions'
                }],
                pagination: {
                    total: 0,
                    per_page: 10,
                    current_page: 1,
                    order_by: 'full_name',
                    order: true,
                },
                filters: {
                    search: ''
                },
                loading: false
            }
        },
        mounted() {
            this.getIndex()
        },
        methods: {
            getIndex(){
                let url = `employees.json?`

                // filters
                url += `filters[search]=${this.filters.search}`

                // pagination
                url += `&per_page=${this.pagination.per_page}&current_page=${this.pagination.current_page}`

                // sorting
                url += `&order=${this.pagination.order}&order_by=${this.pagination.order_by}`

                this.loading = true
                this.http.get(url).then(response => {
                    if (response.successful) {
                        this.data = response.data.employees
                        this.pagination.total = response.data.total_count
                    }

                    this.loading = false
                }).catch(error => {
                    console.log(error)
                })
            },

            deleteRecord(id){
                const url = this.url.build('employees/:id', {id: id})
                this.http.delete(url).then(result => {
                    if (result.successful) {
                        this.data = this.data.filter(e => e.id !== id)
                        this.pagination.total -= 1
                        this.$toast.success('Empleado eliminado exitosamente.')
                    } else {
                        this.$toast.error(result.error.message)
                    }
                }).catch(error => {
                    console.log(error)
                })
            },

            showRecord(employee){
                this.$router.push(`employees/${employee.id}`)
            },

            onSearch(text){
                this.filters.search = text

                this.getIndex()
            },

            onFiltered(filteredItems) {
                this.totalRows = filteredItems.length
                this.currentPage = 1
            }
        },

        watch: {
            'pagination.current_page'() {
                this.getIndex()
            },

            'pagination.order_by'() {
                this.getIndex()
            },

            'pagination.order'(){
                this.getIndex()
            }
        }
    }
</script>

<template>
    <section class="application-component">
        <component-header-list
            title="Empleados"
            title-button-create="Crear"
            :loading="loading"
            @reloadList="getIndex"
        >
        </component-header-list>

        <b-card>
            <component-search-list
                :loading="loading"
                @search="onSearch"
                placeholder-text="Buscar por nombre o dpi ..."
            >
            </component-search-list>

            <b-card-body>
                <b-table
                    striped
                    hover
                    :items="data"
                    :fields="fields"
                    @filtered="onFiltered"
                    @row-clicked="showRecord"
                    :sort-desc.sync="pagination.order"
                    :sort-by.sync="pagination.order_by"
                    responsive
                >
                    <template #head()="{ label, field: { key, sortable }}">
                        {{ label }}
                        <template v-if="sortable">
                            <template>
                                <font-awesome-icon v-if="((pagination.order) && (pagination.order_by === key))" icon="sort-down" />
                                <font-awesome-icon v-else-if="((!pagination.order) && (pagination.order_by === key))" icon="sort-up" />
                            </template>
                        </template>
                    </template>
                   <template v-slot:cell(actions)="row">
                        <b-button variant="outline-danger" @click.stop="deleteRecord(row.item.id)" class="mr-1">
                            <font-awesome-icon icon="trash" />
                        </b-button>
                    </template>
                </b-table>
                <b-col sm="4" md="4">
                    <b-pagination
                        v-model="pagination.current_page"
                        :simple="false"
                        :total-rows="pagination.total"
                        :per-page="pagination.per_page"
                        align="fill"
                        size="sm"
                    ></b-pagination>
                </b-col>
            </b-card-body>
        </b-card>
    </section>
</template>