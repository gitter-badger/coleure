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
    var currentPalette;
    colorDrag = function(event) {
      var color, data;
      color = event.target;
      colorOrigin = _.attr(color, 'data-origin');
      data = {
        name: _.attr(color, 'data-name'),
        hex: _.attr(color, 'data-hex'),
        rgb: _.attr(color, 'data-rgb'),
        hsl: _.attr(color, 'data-hsl'),
        mixed: _.attr(color, 'data-mixed'),
      };
      event.dataTransfer.effectAllowed = 'copy';
      return event.dataTransfer.setData('text', JSON.stringify(data));
    };
    colorOver = function(event) {
      event.preventDefault();
      return event.dataTransfer.dropEffect = 'copy';
    };
    var updateTitle = function(number){
      _.id('activePalette').innerHTML = number? 'No. '+number : 'New';
    }
    var addColor = function(data){
      var request = new XMLHttpRequest();
      request.open("POST", "/colors", true);
      request.onreadystatechange = function () {
        if (request.readyState != 4 || request.status != 200) return;
        var requestData = JSON.parse(request.responseText);
        history.pushState(null, null, window.location.origin + "/palettes/" + requestData["id"] + "/edit")
        currentPalette = requestData["id"]
        updateTitle(requestData["id"])
        _.json('/palettes/'+requestData["id"]+'.json', function(colors){
          data.id = colors[colors.length-1].id;
          _.attr(paletteColors.children.item(0), 'data-id', data.id);
        });
      };
      request.setRequestHeader('Accept', 'application/json');
      request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
      request.setRequestHeader('X-CSRF-Token', getAuthToken());
      if (currentPalette != null) { data.palette_id = currentPalette }
      request.send(_.serialize(data, 'color'));

      _.template(colorTemplate, function(template) {
        return insertColor(template, data);
      });
      _.hide(dropMessage);
      activePalette.push(data);
      updatePaletteButtons();
    }
    colorDrop = function(event) {
      var data;
      event.preventDefault();
      data = JSON.parse(event.dataTransfer.getData('text'));
      data.index = activePalette.length;
      data.id = null;
      // TODO: we actually need to provide the proper id in case the user removes the color right away.
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
    var updatePaletteButtons = function(){
      if (activePalette.length != 0){
        _.id('userMenuNewPaletteButton').classList.remove('active');
        _.id('userMenuEditorButton').classList.add('active');
      } else {
        _.id('userMenuNewPaletteButton').classList.add('active');
        _.id('userMenuEditorButton').classList.remove('active');
      }
    };
    var removeColor = function(index){
      var visualColor = paletteColors.children.item(index)
      activePalette.splice(activePalette.length - index - 1, 1);
      visualColor.classList.add('deleted');

      var request = new XMLHttpRequest();
      request.open("DELETE", "/colors/"+_.attr(visualColor, 'data-id'), true);
      request.onreadystatechange = function () {
        if (request.readyState != 4 || request.status != 200) return;
        var requestData = JSON.parse(request.responseText);
        history.pushState(null, null, window.location.origin + "/palettes/" + requestData["id"] + "/edit")
        currentPalette = requestData["id"]
        updateTitle(requestData["id"])
      };
      request.setRequestHeader('Accept', 'application/json');
      request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
      request.setRequestHeader('X-CSRF-Token', getAuthToken());
      request.send("color[id]="+_.attr(visualColor, 'data-id'));

      setTimeout(function(){
        _.remove(visualColor);
        if (activePalette.length == 0) {
          _.show(dropMessage)
        }
      }, 200)

      updatePaletteButtons();
    }
    replaceColors = function(template) {
      var color, _i, _len;
      while (paletteColors.firstChild) {
        paletteColors.removeChild(paletteColors.firstChild);
      }
      for (_i = 0, _len = activePalette.length; _i < _len; _i++) {
        color = activePalette[_i];
        if (!color.mixed) {
          color.mixed = false;
        }
        color.index = _i;
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
    var setUpPalette = function(){
      var url = window.location.pathname.split("/")
      if (url.indexOf('palettes') !== -1) {
        _.json('/palettes/'+url[2]+'.json', function(colors){
          activePalette = colors
          _.template(colorTemplate, replaceColors);
          updatePaletteButtons();
        })
        updateTitle(url[2])
        currentPalette = url[2]
      } else {
        activePalette = [];
        _.template(colorTemplate, replaceColors);
        updateTitle();
        currentPalette = null;
        updatePaletteButtons();
      }
    }

    var dropdownVisible = false,
        dropdownAppearanceHandler = function(event) {
      dropdownVisible ? palettesDropdown.classList.remove('active') : palettesDropdown.classList.add('active');
      dropdownVisible = !dropdownVisible;
    };

    return {
      addColor: addColor,
      removeColor: removeColor,
      setup: function(options) {
        var dropzone, newPaletteField, palette, _i, _len, _ref;
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
        _.listen(_.id('userMenuNewPaletteButton'), 'mousedown', function(){history.pushState(null, null, window.location.origin); setUpPalette();});
        dropMessage = _.id('drop-message');
        colorTemplate = options.template;

        setUpPalette();

        _.listen(window, 'popstate', setUpPalette);
      }
    }
  });

}).call(this);
