<script>
import EditPoem from "../components/EditPoem.vue";
export default {
  components: {
    EditPoem,
  },
  data() {
    return {
      fadeInToggle: true,
      poemsDb: null,
      name: "",
      editedPoemId: null,
      editPoemToggle: {},
      userPassword: null,
    };
  },
  created() {
    this.fetchPoems();
  },
  methods: {
    fetchPoems() {
      this.fadeInToggle = false;
      fetch("/api")
        .then((response) => response.json())
        .then((result) => {
          this.poemsDb = result;
          this.fadeInToggle = true;
        })
        .catch((error) => {
          console.error("Error:", error);
        });
    },
    removePoem(id, password) {
      if (this.userPassword !== password) {
        this.userPassword = window.prompt(
          "Ange lösenord vid skapelse av dikten för att radera:"
        );
      }
      if (this.userPassword === password) {
        fetch(`/api/${id}`, {
          method: "DELETE",
        })
          .then((response) => response.json())
          .then((result) => {
            console.log(result.message);
            this.fetchPoems();
          })
          .catch((error) => {
            console.error("Error:", error);
          });
      } else {
        alert("Felaktigt lösenord");
      }
    },
    editPoem(poemId, password) {
      if (this.userPassword !== password) {
        this.userPassword = window.prompt(
          "Ange lösenord vid skapelse av dikten för att redigera:"
        );
      }
      if (this.userPassword === password) {
        this.editPoemToggle[poemId] = !this.editPoemToggle[poemId];
      } else {
        alert("Felaktigt lösenord");
      }
    },
    closeEditPoem(poemId) {
      this.editPoemToggle[poemId] = false;
      this.fetchPoems();
    },
  },
};
</script>

<template>
  <div id="poems-container">
    <h2>Mästerverk</h2>
    <div
      class="poem-post"
      :class="{ 'fade-in-animation': fadeInToggle }"
      v-for="poem in poemsDb"
      :key="poem.id"
    >
      <div class="author-container">
        <h3>{{ poem.name }},</h3>
        <span>{{ poem.age }}</span>
      </div>
      <p class="poem-text">
        {{ poem.poemtext }}
      </p>
      <div class="menu-bottom">
        <p class="publish-date">{{ poem.publishdate }}</p>
        <div class="customize-post">
          <p class="edit" @click="editPoem(poem.id, poem.password)">Edit</p>
          <p class="edit" @click="removePoem(poem.id, poem.password)">Remove</p>
        </div>
      </div>
      <EditPoem
        v-if="editPoemToggle[poem.id]"
        :key="poem.id"
        :poem="poem"
        @edits-saved="closeEditPoem(poem.id)"
      />
    </div>
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

.fade-in-animation {
  animation: fadeIn 0.7s ease-in-out forwards;
}

#poems-container {
  width: 70%;
  margin: 0 auto;
  margin-top: 3rem;
  margin-bottom: 6rem;
  h2 {
    font-size: 3rem;
    text-align: center;
    color: $headers;
  }
  .poem-post {
    border-bottom: 1px solid #fff;
    padding: 10px 25px 0 25px;
    margin-top: 3rem;
    .poem-text,
    .publish-date {
      font-style: italic;
    }
    .author-container {
      display: flex;
      align-items: center;
      gap: 8px;
      span {
        margin-top: 2px;
      }
    }
    .menu-bottom {
      display: flex;
      align-items: center;
      margin-top: 2rem;
      .publish-date {
        margin-top: 2rem;
        font-size: 13px;
      }
      .customize-post {
        display: flex;
        gap: 10px;
        margin-left: auto;
        .edit {
          margin-top: 2rem;
          font-size: 13px;
          @include transition(all 0.2s ease);
          &:last-child {
            color: #ff0000;
            &:hover {
              color: #ff0000;
            }
          }
          &:hover {
            cursor: pointer;
            color: #00dc82;
          }
        }
      }
    }
  }
}
</style>
