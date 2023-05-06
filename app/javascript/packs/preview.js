// 画像プレビュースクリプト。uplorderが変化したらfilereaderで読み取ってavatarを差し替える。

window.addEventListener('turbolinks:load', () => { 
      const uploader = document.querySelector('.uploader'); uploader.addEventListener('change', (e) => { 
        const file = uploader.files[0]; 
        const reader = new FileReader(); 
        reader.readAsDataURL(file); 
        reader.onload = () => { 
          const image = reader.result; 
          document.querySelector('.avatar').setAttribute('src', image); 
          } 
        }); 
      }); 