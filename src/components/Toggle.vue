<template>
  <SwitchGroup as="div" class="flex items-center">
    <Switch v-model="enabled" :class="[enabled ? 'bg-indigo-600' : 'bg-gray-200', 'relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2']">
      <span aria-hidden="true" :class="[enabled ? 'translate-x-5' : 'translate-x-0', 'pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out']" />
    </Switch>
    <SwitchLabel as="span" class="ml-3">
      <span class="text-sm font-medium text-gray-900">Case Sensitive</span>
    </SwitchLabel>
  </SwitchGroup>
</template>

<script setup lang="ts">
import { ref, watchEffect } from 'vue'
import { Switch, SwitchGroup, SwitchLabel } from '@headlessui/vue'
const props = defineProps<{
    modelValue: boolean
}>()
const emit = defineEmits<{
    (e:'update:modelValue', value: boolean): void
}>()
const enabled = ref(props.modelValue)
watchEffect(() => {
   emit('update:modelValue', enabled.value) 
})
</script>
