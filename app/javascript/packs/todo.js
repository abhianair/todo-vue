import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'
Vue.use(Vuex)
import Todo from '../todo.vue'
import User from '../todo.vue'
import TurbolinksAdapter from 'vue-turbolinks'

document.addEventListener('turbolinks:load', () => {

  Vue.use(TurbolinksAdapter)

  var element = document.querySelector('#todo-container');
  var element2 = document.querySelector('#nav-container');
  if(element != undefined){
    const app = new Vue({
      el: element,
      data: {
      },
      template: "<Todo/>",
      components: {Todo, User}
    })
  }
})
