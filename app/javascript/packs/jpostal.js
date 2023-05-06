//jpostalの実行コード
$(window).ready( function() {
  $('#job_postal_code').jpostal({
    postcode : [
      '#job_postal_code',
    ],
    address : {
      '#job_prefecture_code'  : '%3',
      '#job_other_address'  : '%4%5%6%7'
    }
  });
});