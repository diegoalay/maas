<script type="text/javascript">
    import componentForm from '../components/form.vue'

    export default {
        components:{
            'component-form': componentForm
        },

        data() {
            return {
                user: {},
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
                const url = `/users/${this.id}.json`
                this.http.get(url).then(result => {
                    if (result.successful) {
                        this.user = result.data
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
            title="Usuario">
        </component-header-form>
        <component-form v-if="user.id" :user="user"></component-form>
    </section>
</template>