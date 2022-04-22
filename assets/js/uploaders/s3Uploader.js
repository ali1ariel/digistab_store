export let S3 = function(entries, onViewError) {
    entries.forEach(entry => {
        let formData = new FormData()
        let {url, fields} = entry.meta
        Object.entries(fields).forEach(([key, value]) => formData.append(key, value))
        formData.append("file", entry.file)
        let xhr = new XMLHttpRequest()
        onViewError(( )=> xhr.abort())
        xhr.onload = () => xhr.status === 204 ? entry.progress(100) : entry.error()
        xhr.upload.addEventListener("progress", (event) => {
            if (event.lengthComputable) {
                let percent = Math.round(event.loaded / event.total * 100)
                if (percent < 100) {
                    entry.progress(percent)
                }
            }
        }
        )
        xhr.open("POST", url, true)
        xhr.send(formData)
    })
}