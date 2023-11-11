<script>
export default {
  data() {
    return {
      showIntro: true,
    };
  },
  methods: {
    launchMain() {
      this.showIntro = false;
      this.$emit("toggle-main");
    },
  },
};
</script>

<template>
  <div id="intro-container" v-if="showIntro">
    <h1>Dikter är kul!</h1>
    <button @click="launchMain">Börja</button>
  </div>
</template>

<style scoped lang="scss">
@import "../style.scss";
#intro-container {
  width: 70%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  h1 {
    font-size: 4rem;
    margin-bottom: 2rem;
  }
  button {
    @include casual-button();
  }
}
</style>
