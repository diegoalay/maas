<script type="text/javascript">
    import componentForm from '../components/form.vue'

    export default {
        components:{
            'component-form': componentForm
        },

        data() {
            return {
                service: {
                    id: null,
                    name: '',
                    schedule: [],
                    color: '#FFFFFF'
                }
            }
        }
    }
</script>

<template>
    <section class="application-component">
        <component-header-form
            title="Crear servicio">
        </component-header-form>
        <component-form :service="service"></component-form>
    </section>
</template>