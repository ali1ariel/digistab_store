import Quill from 'quill';
export let TextEditor = {
  mounted() {
    let quill = new Quill(this.el, {
      theme: 'snow'
    });

    
    quill.on('text-change', function(delta, source) {
        updateHtmlOutput()
    })

    // Return the HTML content of the editor
    function getQuillHtml() { return quill.root.innerHTML; }

    function updateHtmlOutput()
    {
        let html = getQuillHtml();
        document.getElementById('product-form_description').value = html;
    }
    

  },
  updated(){
  }
}