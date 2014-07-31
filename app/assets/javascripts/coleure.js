(function() {
  window.addEventListener('load', function() {
    return require(['./goodies', './settings', './colors', './inspector', './palette', './clipboard', './formats'], function(_, settings, colors, inspector, palette) {
      "use strict";
      colors.load({
        colors: '/assets/colors.json',
        template: '/assets/templates/color.html'
      });
      inspector.setup({
        previewTemplate: '/assets/templates/preview.html',
        singleTemplate: '/assets/templates/test/single.html',
        doubleTemplate: '/assets/templates/test/double.html'
      });
      palette.setup({
        template: '/assets/templates/color.html'
      });
      if(settings.upgradeNotice == undefined){ settings.upgradeNotice = true }
      _.listen(_.id('upgradeNoticeButton'), 'mousedown', function(){
        settings.upgradeNotice = false;
        _.hide(_.id('upgradeNotice'))
      });
      if (settings.upgradeNotice == true) { _.show(_.id('upgradeNotice')) };
    });
  });

}).call(this);
