<script type="text/javascript">
    import componentForm from '../components/form.vue'

    export default {
        components:{
            'component-form': componentForm
        },

        data() {
            return {
                user: {
                    color: '#' + Math.floor(Math.random()*16777215).toString(16)
                }
            }
        }
    }
</script>

<template>
    <section class="application-component">
        <component-header-form
            title="Crear usuario">
        </component-header-form>
        <component-form :user="user"></component-form>
    </section>
</template>