<template>
  <div class="input-field col" :class="cols">
    <input v-model="value" v-el:input class="validate"
      :autocomplete="autocomplete" :disabled="disabled"
      :id="id" :name="name" :placeholder="placeholder"
      :readonly="readonly" :required="required" :type="type"
      @focus="hasFocus=true" @blur="hasFocus=false">
    <label :for="id" :class="{active:labelActive}"><slot></slot></label>
  </div>
</template>
<script>
module.exports = {
  props: ["autocomplete", "cols", "disabled", "focus", "id", "name", "placeholder", "readonly", "required", "type", "value"],
  data: function() {
    return {hasFocus: false, mdValue: ""};
  },
  computed: {
    labelActive: function() {
      return this.value || this.placeholder || this.hasFocus;
    }
  },
  ready: function() {
    if (typeof this.autocomplete == "undefined" && !this.id) this.autocomplete = "new-password";
    if (!this.cols) this.cols = "s12";
    if (!this.type) this.type = "text";
    if (!this.id) this.id = Materialize.guid();
    if (this.focus) this.$els.input.focusOnDesktop();
  }
};
</script>
