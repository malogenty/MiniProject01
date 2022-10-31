<template>
  <div class="card">
    <div class="card__image card__image--fence"></div>
    <div class="card__content">
      <div class="card__title">{{ user.username }}</div>
      <p class="card__text">
        {{ user.email }}
      </p>
      <button class="btn btn--block card__btn">More information</button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      username: String,
      email: String,
      id: Number,
    },
  },
  name: "UserCard",
  data() {
    return {
      //   user: {}
    };
  },
};
</script>

<style>

.btn {
  background-color: white;
  border: 1px solid #444444;
  /* //border-radius: 1rem; */
  /* color: @gray-dark; */
  padding: 0.5rem;
  text-transform: lowercase;
}

.btn--block {
  display: block;
  width: 100%;
}

.cards__item {
  display: flex;
  padding: 1rem;
  @media (min-width: 40rem) {
    width: 50%;
  }
  @media (min-width: 56rem) {
    width: 33.3333%;
  }
}

.card {
  background-color: white;
  border-radius: 0.25rem;
  box-shadow: 0 20px 40px -14px rgba(0, 0, 0, 0.25);
  display: flex;
  flex: 0 1 24%;
  flex-direction: column;
  overflow: hidden;
  /* &:hover {
    .card__image {
      filter: contrast(100%);
    }
  } */
}

.card__content {
  display: flex;
  flex: 0 1 auto;
  flex-direction: column;
  padding: 1rem;
}

.card__title {
  /* color: @gray-dark; */
  font-size: 1.25rem;
  font-weight: 300;
  letter-spacing: 2px;
  text-transform: uppercase;
}

.card__text {
  flex: 1 1 auto;
  font-size: 0.875rem;
  line-height: 1.5;
  margin-bottom: 1.25rem;
}
</style>