(function() {

  define(['./goodies', './settings'], function(_, settings) {
    var activePalette, 
        addPalette, 
        colorDrag, 
        colorDrop, 
        colorOver, 
        colorTemplate, 
        createPalette, 
        dropMessage, 
        insertColor, 
        newPaletteField_changeHandler, 
        paletteColorDrag, 
        paletteColorDrop, 
        paletteColorOver, 
        paletteColors, 
        palettesDropdown,
        palettesDropdownLabel, 
        palettesList, 
        palettesList_clickHandler, 
        removePalette, 
        replaceColors, 
        setup, 
        switchPalette,
        colorOrigin;
    palettesDropdownLabel = null;
    palettesList = null;
    paletteColors = null;
    dropMessage = null;
    colorTemplate = null;
    activePalette = [];
    colorDrag = function(event) {
      var color, data;
      color = event.target;
      colorOrigin = _.attr(color, 'data-origin');
      data = {
        name: _.attr(color, 'data-name'),
        hex: _.attr(color, 'data-hex'),
        rgb: _.attr(color, 'data-rgb'),
        hsl: _.attr(color, 'data-hsl'),
        mixed: _.attr(color, 'data-mixed')
      };
      event.dataTransfer.effectAllowed = 'copy';
      return event.dataTransfer.setData('text', JSON.stringify(data));
    };
    colorOver = function(event) {
      event.preventDefault();
      return event.dataTransfer.dropEffect = 'copy';
    };
    var addColor = function(data){
      _.template(colorTemplate, function(template) {
        return insertColor(template, data);
      });
      _.hide(dropMessage);
      console.log(data)
      console.log(activePalette)
      activePalette.push(data);
    }
    colorDrop = function(event) {
      var data;
      event.preventDefault();
      data = JSON.parse(event.dataTransfer.getData('text'));
      data.inpalette = "true";
      data.index = activePalette.length;
      data.paletteIndex = 1;
      addColor(data);
    };
    paletteColorDrag = function(event) {
      var index, paletteColor;
      event.dataTransfer.effectAllowed = 'move';
      paletteColor = event.target;
      colorOrigin = _.attr(paletteColor, 'data-origin');
      index = _.indexOf(paletteColor.parentNode.children, paletteColor);
      return event.dataTransfer.setData('text', index);
    };
    paletteColorOver = function(event) {
      event.preventDefault();
      return event.dataTransfer.dropEffect = 'move';
    };
    paletteColorDrop = function(event) {
      var index, origin;
      event.preventDefault();
      index = event.dataTransfer.getData('text');
      if (colorOrigin == "palette") {
        removeColor(index);
      }
    };
    var removeColor = function(index){
      var visualColor = paletteColors.children.item(index)
      activePalette.splice(activePalette.length - index - 1, 1);
      visualColor.classList.add('deleted');
      setTimeout(function(){
        _.remove(visualColor);
        if (activePalette.length == 0) {
          _.show(dropMessage)
        }
      }, 200)
    }
    replaceColors = function(template) {
      var color, _i, _len;
      while (paletteColors.firstChild) {
        paletteColors.removeChild(paletteColors.firstChild);
      }
      for (_i = 0, _len = activePalette.length; _i < _len; _i++) {
        color = activePalette[_i];
        if (!color.mixed) { 
          color.mixed = 'false';
        }
        color.index = _i;
        color.paletteIndex = settings.activePaletteIndex;
        insertColor(template, color);
      }
      if (paletteColors.children.length) {
        return _.hide(dropMessage);
      } else {
        return _.show(dropMessage);
      }
    };
    insertColor = function(template, color) {
      var el;
      el = _.create('i');
      paletteColors.insertBefore(el, paletteColors.firstChild);
      color.origin = "palette";
      el.outerHTML = template(color);
    };

    var dropdownVisible = false,
        dropdownAppearanceHandler = function(event) {
      dropdownVisible ? palettesDropdown.classList.remove('active') : palettesDropdown.classList.add('active');
      dropdownVisible = !dropdownVisible;
    };

    return {
      addColor: addColor,
      removeColor: removeColor,
      setup: function(options) {
        var activePaletteIndex, dropzone, newPaletteField, palette, _i, _len, _ref;
        dropzone = _.id('palette');
        _.listen(dropzone, 'dragenter', colorOver);
        _.listen(dropzone, 'dragover', colorOver);
        _.listen(dropzone, 'drop', colorDrop);
        _.listen(_.id('colors'), 'dragstart', colorDrag);
        _.listen(_.id('subjects'), 'dragstart', colorDrag);
        paletteColors = _.id('palette_colors');
        _.listen(paletteColors, 'dragstart', paletteColorDrag);
        _.listen(_.id('colors'), 'dragenter', paletteColorOver);
        _.listen(_.id('colors'), 'dragover', paletteColorOver);
        _.listen(_.id('colors'), 'drop', paletteColorDrop);
        dropMessage = _.id('drop-message');
        colorTemplate = options.template;
        _ref = settings.palettes;
        // for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          // palette = _ref[_i];
          // addPalette(palette.name);
        // }
        activePaletteIndex = 0;
      }
    }
  });

}).call(this);
