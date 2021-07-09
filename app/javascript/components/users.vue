<template>
  <div>
    <div v-for="(user, index) in users" :key="index" class="el">
      <div class="" v-on:click="nav_click_user(user, index)" :class="{'nav-item-active': index === activeNav}">
        {{user.username}}
      </div>
    </div>
  </div>
</template>


<script>
  const headers = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
  }

  export default {
    props: ['items', 'assignee'],
    data: () => {
      return {
        users: [],
        activeNav: null,
      }
    },
    created: function() {
      fetch('/accounts')
      .then((response) => response.json())
      .then((data) => this.users = data)
    },
    methods: {
      nav_click_user: function(user, index){
        this.activeNav = index;
        this.$emit('loading', true)
        fetch(`/todos?assignee=${user.id}`)
        .then((response) => response.json())
        .then((data) => {
          this.$emit('loading', false);
          this.$emit('new-item', data);
          this.$emit('change-assignee', user.id);

        })
      }
    }
  }
</script>
