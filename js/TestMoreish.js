if (! _TestMoreish)
    var _TestMoreish = {};

(function(){ 

    var YuA = YAHOO.util.Assert;

	_TestMoreish.ok = function( ok, name ) {
        _TestMoreish_ok( ok, name );
    }

    var assertionTo_Tester = function( test ) {
        return function() {
            var error;
            try {
                test.apply( YuA, arguments );
            }
            catch (thrown) {
                if (! thrown instanceof YAHOO.util.AssertionError)
                    throw ( thrown );
                error = thrown;
            }
            return error ? error : null;
        };
    }

    var assertionToTester = function( test ) {
		return function() {
            var tester = this['_' + test];
            var error = tester.apply( this, arguments );
            var hasError = error ? 0 : 1;
            this.ok( hasError );
            return hasError;
            /* TODO Need to handle the name/description argument */
        };
    }
	
    var _test = [
        'areEqual',
        'areNotEqual',
        'areSame',
        'areNotSame',
        'fail',
        'isTypeOf',
        'isArray',
        'isBoolean',
        'isFunction',
        'isNumber',
        'isObject',
        'isString',
        'isInstanceOf',
        'isTrue',
        'isFalse',
        'isNaN',
        'isNotNaN',
        'isNull',
        'isNotNull',
        'isUndefined',
        'isNotUndefined'
    ];

    for (ii = 0; ii < _test.length; ii++) {
        var name = _test[ii];
        _TestMoreish['_' + name] = assertionTo_Tester( YAHOO.util.Assert[name] );
        _TestMoreish[name] = assertionToTester( name );
    }

})();

lfdfkdljf
