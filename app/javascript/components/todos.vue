<template>
  <div class="col-md-12 mgtop20p">
    <div>
      <div v-if="loading">
        <div class="loader">Loading...</div>
      </div>
      <div v-else>
        <div class="todo-wrapper">
          <div v-if="items.length == 0">
            <p>There are no Todos</p>
          </div>
          <div v-else v-for="(item, index) in items" :key="item.id" class="row col-md-6 todo-box" :class="{'low_opac': status_class(item)}">
            <div class="col-md-6">
              <textarea v-model="item.body" v-on:change="updateItem(item)" class="form-control"></textarea>
            </div>
            <div class="col-md-1">
              <input type="checkbox" v-on:change="ItemStatus(item, $event)" :checked="get_status(item)">
            </div>
            <div class="col-md-2">
              <button v-on:click="updateItem(item)" class="btn btn-primary">Update</button>
            </div>
            <div class="col-md-1">
              <button v-on:click="deleteItem(item.id, index)" class="btn btn-danger">X</button>
            </div>
            <div class="todo-ruser">
              {{item.ruser.username}} on {{get_month_day(item.created_at)}}
            </div>
          </div>
        </div>
        <div class="">
          <div class="row mgtop20p">
            <div class="col-md-8">
              <textarea v-model="newItem" class="form-control" placeholder="Add new item..."></textarea>
              <input type="hidden" v-model="assignee">
            </div>
            <div class="col-md-1">
              <button v-on:click="addItem" class="btn btn-success sq_btn"><span v-if="add_new_btn_load"><div class="buttonloader">Loading...</div></span><span v-else>Add</span></button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  const headers = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }

  export default {
    props:['items', 'assignee', 'loading'],
    data: () => {
      return {
        newItem: '',
        add_new_btn_load: false
      }
    },
    created: function() {
      //fetch('/todos')
      //  .then((response) => response.json())
      //  .then((data) => this.items = data)
    },
    methods: {
      get_month_day: function(date){
        var date = new Date(date);
        return date.getDate()+ ' ' + date.toLocaleString('default', { month: 'short' }) + ' ' + date.getFullYear()
      },
      status_class: function(item){
        return item.status == "done" ? true : false
      },
      get_status: function(item) {
        return item.status == "todo" ? 0 : 1
      },
      addItem: function(){
      let vm = this;
      this.add_new_btn_load= true;
        fetch('/todos', {
            method: 'POST',
            body: JSON.stringify({ body: vm.newItem, assignee: vm.assignee }),
            headers: headers })
        .then((response) => response.json())
        .then((data) => {
          vm.items.unshift({
            id: data.id,
            body: data.body,
            status: data.status,
            ruser: data.ruser,
            created_at: data.created_at
          })
          this.add_new_btn_load= false;
          vm.newItem = ''
        })
      },
      deleteItem: function(itemId, index){
        fetch(`/todos/${itemId}`, { method: 'DELETE' })
        .then(() => {
          this.items.splice(index, 1)
        })
      },
      updateItem: function(item){
        fetch(`/todos/${item.id}`, {
        method: 'PUT',
        body: JSON.stringify({ body: item.body}),
        headers: headers })
      },
      ItemStatus: function(item, event){
        var value = event.target.checked ? 1 : 0;
        if(event.target.checked){
          $(event.target).parent().parent().addClass('low_opac');
        }else{
          $(event.target).parent().parent().removeClass('low_opac');
        }
        fetch(`/todos/update_status/${item.id}`, {
        method: 'PUT',
        body: JSON.stringify({ status: value}),
        headers: headers })
        .then((response) => response.json())
        .then((data) => {
        })
      }
    }
  }
</script>
