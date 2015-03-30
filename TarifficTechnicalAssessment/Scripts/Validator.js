Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function () {
    function getValidator() {
        return $(this).parent().find('.ErrorMsg').filter(function () { return $(this).css('display') != 'none'; });
    }



    var inputs = '.Validate input:text, .Validate select, .Validate input:password';
    var submit = $('input:submit');
   var q = $(inputs).qtip({

        position: {

            my: 'center left',

            at: 'center right'

        },

        content: {

            text: function (api) {

                return getValidator.call(this).html();

            }

        },

        show: {

            ready: true,

            event: 'none'

        },

        hide: {

            event: 'none'

        },

        style: {

            classes: 'ui-tooltip-red ui-tooltip-shadow ui-tooltip-rounded'

        },

        events: {

            show: function (event, api) {

                var $this = api.elements.target;

                var validator = getValidator.call($this);

                if (validator.length == 0)

                    event.preventDefault();

            }

        }

    });



    if (window.Page_ClientValidate != undefined) {

        function afterValidate() {

            $(inputs).each(function () {

                var validator = getValidator.call(this);



                if (validator.length > 0) {

                    var text = validator.html();



                    $(this).addClass('Error').qtip('show').qtip('option', 'content.text', text);

                    //                    validator.hide();



                }

                else

                    $(this).removeClass('Error').qtip('hide');

            });

        }



        $(inputs).blur(afterValidate);



        var oldValidate = Page_ClientValidate;



        Page_ClientValidate = function (group) {

            oldValidate(group);



            afterValidate.call(this);



            submit.removeAttr('disabled');

        }

    }

});

