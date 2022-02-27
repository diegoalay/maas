<script type="text/javascript">
    import componentForm from '../components/form.vue'

    export default {
        components:{
            'component-form': componentForm
        },

        data() {
            return {
                service: {
                    schedule: []
                },
                id: null
            }
        },

        mounted(){
            this.setId()
            this.getData()
        },

        methods:{
            setId(){
                this.id = this.$route.params.id
            },

            getData(){
                const url = `/services/${this.id}.json`
                this.http.get(url).then(result => {
                    if (result.successful) {
                        this.service = result.data
                    }else{
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
    <section>
        <component-header-form
            title="Servicio">
        </component-header-form>
        <component-form v-if="service.id" :service="service"></component-form>
    </section>
</template>