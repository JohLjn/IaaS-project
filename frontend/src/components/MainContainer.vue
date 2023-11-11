<script>
import PoemContainer from "../components/PoemContainer.vue";
export default {
  components: {
    PoemContainer,
  },
  data() {
    return {
      name: null,
      age: null,
      password: null,
      poemtext: null,
      publishdate: null,
      updateKey: 1,
      easterEgg: false,
    };
  },
  methods: {
    applyPoem() {
      this.publishdate = this.currentDate;
      fetch("/api", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          name: this.name,
          age: this.age,
          password: this.password,
          poemtext: `"${this.poemtext}"`,
          publishdate: this.publishdate,
        }),
      }).then(() => {
        this.updateKey++;
        this.easterEgg = true;
      });
    },
  },
  computed: {
    currentDate() {
      const now = new Date();
      const day = String(now.getDate()).padStart(2, "0");
      const month = String(now.getMonth() + 1).padStart(2, "0");
      const year = now.getFullYear();
      const hours = String(now.getHours()).padStart(2, "0");
      const minutes = String(now.getMinutes()).padStart(2, "0");
      const seconds = String(now.getSeconds()).padStart(2, "0");
      return `${day}/${month}/${year} ${hours}:${minutes}:${seconds}`;
    },
  },
};
</script>

<template>
  <div class="main-container">
    <div id="form-container">
      <h2>Framhäv din kreativa <span>diktkunskap!</span></h2>
      <form @submit.prevent="applyPoem" v-if="!easterEgg">
        <div id="input-info">
          <div class="align-info">
            <label for="name">Namn *</label>
            <input
              v-model="name"
              type="text"
              id="name"
              required
              placeholder="-"
            />
          </div>
          <div class="align-info">
            <label for="age">Årtal *</label>
            <input
              v-model="age"
              type="number"
              id="age"
              required
              placeholder="-"
            />
          </div>
          <div class="align-info">
            <label for="password">Lösenord * </label>
            <input
              v-model="password"
              type="password"
              id="password"
              required
              placeholder="-"
            />
            <span>För att kunna redigera & ta bort.</span>
          </div>
        </div>
        <textarea
          v-model="poemtext"
          placeholder="Gud som haver programmerare kär..."
          required
        ></textarea>
        <button type="submit">Skicka!</button>
      </form>
      <div id="form-sent" v-else>
        <h3>Tack för ditt bidrag!</h3>
        <p id="easter-egg">
          ^.&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp.^<br />( @ )<br />
        </p>
      </div>
    </div>
    <PoemContainer :key="updateKey" />
  </div>
</template>

<style scoped lang="scss">
@import "../style.scss";

@keyframes fadeIn {
  0% {
    opacity: 0;
    transform: translateY(10%);
  }
  100% {
    opacity: 1;
    transform: translateY(0%);
  }
}

.main-container {
  width: 70%;
  #form-container {
    padding: 50px;
    border-bottom: 1px solid #fff;
    transform: translateY(10%);
    animation: fadeIn 0.7s ease-in-out forwards;
    form {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
  }
  h2 {
    font-size: 3rem;
    text-align: center;
    span {
      color: #00dc82;
    }
  }
  textarea {
    border: 1px solid #fff;
    padding: 15px;
    width: 50%;
    height: 20vh;
    color: #fff;
    margin-top: 3rem;
    @include border-radius(3px);
    background: $primary-color;
    &::placeholder {
      color: #fff;
    }
    &:focus {
      outline: none;
    }
  }
  button {
    @include casual-button();
    margin-top: 2.5rem;
  }
  #input-info {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 30px;
    width: 40%;
    margin-top: 2rem;
    .align-info {
      width: 100%;
      display: flex;
      flex-direction: column;
      span {
        margin-top: 10px;
        font-size: 11px;
        color: #eee;
      }
    }
    input {
      padding: 5px 5px 5px 2px;
      border: none;
      border-bottom: 1px solid #fff;
      background: $primary-color;
      font-size: 1rem;
      color: #fff;
      &:focus {
        outline: none;
      }
    }
  }
  label {
    margin-bottom: 7px;
    font-weight: 600;
  }

  #form-sent {
    animation: fadeIn 0.7s ease-in-out forwards;
    margin-top: 5.5rem;
    h3 {
      font-size: 2rem;
      text-align: center;
    }
    #easter-egg {
      text-align: center;
      color: rgb(238, 135, 152);
      font-size: 8rem;
    }
  }
}
</style>
