import appServicesList  from './apps/list.vue'
import appServicesNew   from './apps/new.vue'
import appServicesShow from './apps/show.vue'

const routes =  [
    {
        path: "/services",
        component: appServicesList
    },
    {
        path: "/services/new",
        component: appServicesNew
    },
    {
        path: "/services/:id",
        component: appServicesShow
    }
]

export default routes;