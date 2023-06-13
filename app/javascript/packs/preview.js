// 画像プレビュースクリプト。uplorderが変化したらfilereaderで読み取ってavatarを差し替える。

window.addEventListener('turbolinks:load', () => {

  //uplorderの内容を取得
  const uploader = document.querySelector('.uploader');

  //uplorderが変化したときに発火する
  uploader.addEventListener('change', (e) => {
    const file = uploader.files[0];
    const reader = new FileReader();

    //uplorderの内容をFileReaderする
    reader.readAsDataURL(file);

    //↑が動いたら発火、avaterのところをreaderの読み取り結果=imageに置き換える。
    reader.onload = () => {
      const image = reader.result;
      document.querySelector('.avatar').setAttribute('src', image);
      }
    });
  });