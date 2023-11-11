<script>
export default {
  data() {
    return {
      poemsDb: null,
      editName: this.poem.name,
      editAge: this.poem.age,
      editPoemtext: this.poem.poemtext,
    };
  },
  props: {
    poem: Object,
  },
  methods: {
    editPoem() {
      fetch(`/api/${this.poem.id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          newName: this.editName,
          newAge: this.editAge,
          newPoemtext: this.editPoemtext,
          newDate: this.currentDate,
        }),
      })
        .then((response) => response.json())
        .then((result) => {
          console.log(result.message);
          this.$emit("edits-saved");
        })
        .catch((error) => {
          console.error("Error:", error);
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
  <div id="edit-container">
    <form @submit.prevent="editPoem">
      <label for="edit-name">Namn</label>
      <input v-model="editName" type="text" id="edit-name" required />
      <label for="edit-age">Ålder</label>
      <input v-model="editAge" type="number" id="edit-age" required />
      <textarea
        v-model="editPoemtext"
        placeholder="Ändra dikt..."
        required
      ></textarea>
      <button type="submit">Bekräfta ändringar</button>
    </form>
  </div>
</template>

<style scoped lang="scss">
@import "../style.scss";

@keyframes fadeIn {
  0% {
    transform: translateY(-15px);
    opacity: 0;
  }
  100% {
    opacity: 1;
    transform: translateY(0px);
  }
}

form {
  transform: translateY(-15px);
  border-top: 1px solid #fff;
  padding-top: 15px;
  display: flex;
  flex-direction: column;
  gap: 20px;
  margin: 20px 0;
  animation: fadeIn 0.3s ease-in-out forwards;
  label {
    font-size: 10px;
    margin-bottom: -15px;
  }
  input {
    padding: 5px 5px 5px 2px;
    &:focus {
      outline: none;
    }
  }
  textarea {
    height: 15vh;
    background: $primary-color;
    padding: 15px;
    border: 1px solid #fff;
    color: #fff;
    &::placeholder {
      color: #fff;
    }
    &:focus {
      outline: none;
    }
  }
  button {
    @include casual-button();
    width: 20%;
    padding: 10px;
    font-size: 14px;
  }
}
</style>
