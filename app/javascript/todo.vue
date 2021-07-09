<template>
  <div id="user-nav">
    <div class="sidenav">
      <users @new-item="addNewItem" @change-assignee="changeAssignee" @loading="LoadingProgress"></users>
    </div>
    <div class="main">
      <items :items="items" :assignee="assignee" :loading=loading></items>
    </div>
  </div>
</template>

<script>
  import Items from "./components/todos";
  import Users from "./components/users"
  export default {
    data: () =>{
      return {
        items: [],
        new_item: "",
        assignee: "",
        loading: false
      }
    },
    components: { Items, Users },
    methods: {
      addNewItem: function(items){
        this.items = items;
      },
      changeAssignee: function(data){
        this.assignee = data;
      },
      LoadingProgress: function(flag){
        this.loading = flag;
      }
    }
  }

</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
