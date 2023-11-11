<script>
import IntroContainer from "./components/IntroContainer.vue";
import MainContainer from "./components/MainContainer.vue";
import ForLulz from "./components/ForLulz.vue";

export default {
  data() {
    return {
      showIntro: true,
      bigLaunch: true,
    };
  },
  components: {
    IntroContainer,
    MainContainer,
    ForLulz,
  },
  created() {
    setTimeout(() => {
      this.bigLaunch = false;
    }, 13000);
  },
};
</script>

<template>
  <div id="container">
    <ForLulz v-if="bigLaunch" />
    <transition v-else name="slide-fade" mode="out-in">
      <IntroContainer
        v-if="showIntro"
        @toggle-main="showIntro = false"
        key="intro"
      />
      <MainContainer v-else key="main" />
    </transition>
  </div>
</template>

<style scoped lang="scss">
@import "./style.scss";
#container {
  display: flex;
  justify-content: center;
  align-items: center;
}

.slide-fade-enter-active,
.slide-fade-leave-active {
  @include transition(all 0.9s ease);
}
.slide-fade-enter,
.slide-fade-leave-to {
  opacity: 0;
  transform: translateY(-20%);
}
</style>
