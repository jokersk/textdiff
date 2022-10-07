<template>
    <div class="">
        <label for="about" class="block text-sm font-medium text-gray-700">{{ label }}</label>
        <div class="mt-1">
            <textarea
                id="about"
                name="about"
                rows="10"
                class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
                :value="modelValue"
                @input="(e: Event) => $emit('update:modelValue', (e.target as HTMLInputElement).value)"
            ></textarea>
        </div>
    </div>
</template>
<script setup lang="ts">
defineProps<{
    label: string,
    modelValue: string
}>()
</script>
