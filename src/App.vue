<template>
    <div class="grid justify-center items-center">
        <Top></Top>
        <div class="grid grid-cols-2 gap-4">
            <TextAreaVue v-model="form.leftText" label="Text in Page"></TextAreaVue>
            <TextAreaVue v-model="form.rightText" label="Text in Figma"></TextAreaVue>
            <div class="col-span-full">
                <Toggle v-model="form.isCaseSensitive"></Toggle>
            </div>
            <div class="col-span-full">
                <button
                    @click="compare"
                    type="button"
                    class="inline-flex items-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                >
                    Compare
                </button>
            </div>
            <div v-if="!form.result" class="rounded-md bg-red-50 p-4 col-span-full">
                <div>
                    <div class="flex">
                        <div class="ml-3">
                            <h3 class="text-sm font-medium text-red-800">There were few differences</h3>
                            <div class="mt-2 text-sm text-red-700">
                                <ul role="list" class="list-disc space-y-1 pl-5">
                                    <li>Remove: {{ form.removed }}</li>
                                    <li>Added: {{ form.added }}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div v-if="form.result && form.compared" class="rounded-md bg-green-50 p-4 col-span-full">
                <div class="flex">
                    <div class="ml-3">
                        <h3 class="text-sm font-medium text-green-800">No Diff!</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup lang="ts">
import { reactive } from 'vue'
import TextAreaVue from './components/TextArea.vue'
import Top from './components/Top.vue'
import Toggle from './components/Toggle.vue'


const removeHTML = (str: string): string => {
    str = str.replaceAll(/\<.*?\>/g, '')
    str = str.replaceAll(/\<\/.*?>/g, '')
    str = str.replaceAll(' ', '')
    str = str.replaceAll(/\n/g, '')
    if (!form.isCaseSensitive) {
        str = str.toLowerCase()
    }
    return str
}

const form = reactive({
    leftText: '',
    rightText: '',
    result: true,
    isCaseSensitive: true,
    removed: '',
    added: '',
    compared: false
})

const compare = () => {
    form.compared = false
    const a = removeHTML(form.leftText)
    const b = removeHTML(form.rightText)
    form.result = a.includes(b)
    form.compared = true
    form.removed = ''
    form.added = ''
    if (form.result) return
    findDiff(a, b)
}

const findDiff = (a: string, b: string) => {
    if (a.indexOf(b[0]) > -1) {
        let index = a.indexOf(b[0])
        while (a[index]) {
            if (a[index] != b[index]) {
                form.removed += a[index]
                b[index] && (form.added += b[index])
            }
            index++
        }
        return
    }
    form.removed = a
    form.added = b
}
</script>
