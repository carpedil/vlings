<script lang="ts">
    import { onMount } from "svelte";
    let hello:string = ''
    onMount(async ()=>{
        let req = await fetch('http://localhost:8082/diff/hello',{
            method:'GET'

        })
        hello = await req.json()
        console.log(hello)
    }) 
</script>
<div>This is Diff page</div>
<div>
    <p class="h1">{hello}</p>
</div>