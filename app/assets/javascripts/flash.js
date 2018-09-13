window.setTimeout(function(){
  const alerts = document.querySelectorAll('.alert');
  alerts.forEach(function(key) {
    key.classList.add('slideRight-away')
    setTimeout(function(){
      key.style.setProperty('display', `none`);;
    }, 900);
  })
}, 8000);


  // function playSound(e) {
  //   const audio = document.querySelector(`audio[data-key="${e.keyCode}"]`);
  //   const key = document.querySelector(`div[data-key="${e.keyCode}"]`);
  //   if (!audio) return;

  //   key.classList.add('playing');
  //   audio.currentTime = 0;
  //   audio.play();
  // }

  // const keys = Array.from(document.querySelectorAll('.key'));
  // keys.forEach(key => key.addEventListener('transitionend', removeTransition));
  // window.addEventListener('keydown', playSound);
