(function(f) {
    f.fn.noUiSlider = function(n, r) {
        function s(a, e, c) {
            var g = e.data("setup"),
            l = g.handles;
            e = g.settings;
            g = g.pos;
            a = 0 > a ? 0 : 100 < a ? 100 : a;
            2 == e.handles && (c.is(":first-child") ? (c = parseFloat(l[1][0].style[g]) - e.margin, a = a > c ? c: a) : (c = parseFloat(l[0][0].style[g]) + e.margin, a = a < c ? c: a));
            e.step && (c = m.from(e.range, e.step), a = Math.round(a / c) * c);
            return a
        }
        function t(a) {
            try {
                return [a.clientX || a.originalEvent.clientX || a.originalEvent.touches[0].clientX, a.clientY || a.originalEvent.clientY || a.originalEvent.touches[0].clientY]
            } catch(e) {
                return ["x", "y"]
            }
        }
        var j = window.navigator.msPointerEnabled ? 2 : "ontouchend" in document ? 3 : 1;
        window.debug && console && console.log(j);
        var m = {
            to: function(a, e) {
                e = 0 > a[0] ? e + Math.abs(a[0]) : e - a[0];
                return 100 * e / this._length(a)
            },
            from: function(a, e) {
                return 100 * e / this._length(a)
            },
            is: function(a, e) {
                return e * this._length(a) / 100 + a[0]
            },
            _length: function(a) {
                return a[0] > a[1] ? a[0] - a[1] : a[1] - a[0]
            }
        },
        w = {
            handles: 2,
            serialization: {
                to: ["", ""],
                resolution: 0.01
            }
        };
        methods = {
            create: function() {
                return this.each(function() {
                    var a = f.extend(w, n),
                    e = f(this).data("_isnS_", !0),
                    c = [],
                    g,
                    l,
                    b = "",
                    h = function(a) {
                        return ! isNaN(parseFloat(a)) && isFinite(a)
                    },
                    k = (a.serialization.resolution = a.serialization.resolution || 0.01).toString().split("."),
                    q = 1 == k[0] ? 0 : k[1].length;
                    a.start = h(a.start) ? [a.start, 0] : a.start;
                    f.each(a,
                    function(b, d) {
                        h(d) ? a[b] = parseFloat(d) : "object" == typeof d && h(d[0]) && (d[0] = parseFloat(d[0]), h(d[1]) && (d[1] = parseFloat(d[1])));
                        var c = !1;
                        d = "undefined" == typeof d ? "x": d;
                        switch (b) {
                        case "range":
                        case "start":
                            c = 2 != d.length || !h(d[0]) || !h(d[1]);
                            break;
                        case "handles":
                            c = 1 > d || 2 < d || !h(d);
                            break;
                        case "connect":
                            c = "lower" != d && "upper" != d && "boolean" != typeof d;
                            break;
                        case "orientation":
                            c = "vertical" != d && "horizontal" != d;
                            break;
                        case "margin":
                        case "step":
                            c = "undefined" != typeof d && !h(d);
                            break;
                        case "serialization":
                            c = "object" != typeof d || !h(d.resolution) || "object" == typeof d.to && d.to.length < a.handles;
                            break;
                        case "slide":
                            c = "function" != typeof d
                        }
                        c && console && console.error("Bad input for " + b + " on slider:", e)
                    });
                    a.margin = a.margin ? m.from(a.range, a.margin) : 0;
                    if (a.serialization.to instanceof jQuery || "string" == typeof a.serialization.to || !1 === a.serialization.to) a.serialization.to = [a.serialization.to];
                    "vertical" == a.orientation ? (b += "vertical", g = "top", l = 1) : (b += "horizontal", g = "left", l = 0);
                    b += a.connect ? "lower" == a.connect ? " connect lower": " connect": "";
                    e.addClass(b);
                    for (b = 0; b < a.handles; b++) {
                        c[b] = e.append("<a><div></div></a>").children(":last");
                        k = m.to(a.range, a.start[b]);
                        c[b].css(g, k + "%");
                        100 == k && c[b].is(":first-child") && c[b].css("z-index", 2);
                        var k = (1 === j ? "mousedown": 2 === j ? "MSPointerDown": "touchstart") + ".noUiSliderX",
                        r = (1 === j ? "mousemove": 2 === j ? "MSPointerMove": "touchmove") + ".noUiSlider",
                        v = (1 === j ? "mouseup": 2 === j ? "MSPointerUp": "touchend") + ".noUiSlider";
                        c[b].find("div").on(k,
                        function(b) {
                            f("body").bind("selectstart.noUiSlider",
                            function() {
                                return ! 1
                            });
                            if (!e.hasClass("disabled")) {
                                f("body").addClass("TOUCH");
                                var d = f(this).addClass("active").parent(),
                                h = d.add(f(document)).add("body"),
                                k = parseFloat(d[0].style[g]),
                                j = t(b),
                                u = j,
                                n = !1;
                                f(document).on(r,
                                function(b) {
                                    b.preventDefault();
                                    b = t(b);
                                    if ("x" != b[0]) {
                                        b[0] -= j[0];
                                        b[1] -= j[1];
                                        var p = [u[0] != b[0], u[1] != b[1]],
                                        f = k + 100 * b[l] / (l ? e.height() : e.width()),
                                        f = s(f, e, d);
                                        if (p[l] && f != n) {
                                            d.css(g, f + "%").data("input").val(m.is(a.range, f).toFixed(q));
                                            var p = a.slide,
                                            h = e.data("_n", !0);
                                            "function" === typeof p && p.call(h, void 0);
                                            n = f;
                                            d.css("z-index", 2 == c.length && 100 == f && d.is(":first-child") ? 2 : 1)
                                        }
                                        u = b
                                    }
                                }).on(v,
                                function() {
                                    h.off(".noUiSlider");
                                    f("body").removeClass("TOUCH");
                                    e.find(".active").removeClass("active").end().data("_n") && e.data("_n", !1).change()
									
									var strValue=parseInt(d.css(g, f + "%").data("input").val());
									
									if(strValue%2!=0)
									{
										
										strValue+=1;
									}

						            $.pps.setVolume(parseInt(strValue));
                                })
                            }
                        }).on("click",
                        function(a) {
                            a.stopPropagation()
                        })
                    }
                    if (1 == j) e.on("click",
                    function(b) {
                        if (!e.hasClass("disabled")) {
                            var d = t(b);
                            b = 100 * (d[l] - e.offset()[g]) / (l ? e.height() : e.width());
                            d = 1 < c.length ? d[l] < (c[0].offset()[g] + c[1].offset()[g]) / 2 ? c[0] : c[1] : c[0];
                            b = s(b, e, d);
                            d.css(g, b + "%").data("input").val(m.is(a.range, b).toFixed(q));
                            b = a.slide;
                            "function" === typeof b && b.call(e, void 0);
                            e.change()
							
							var strValue=f(this).val();							
							if(strValue%2!=0)
							{
								strValue+=1;
								
							}
							window.external.SetSystemVolume(strValue);
							//alert(strValue);
                        }
                    });
                    for (b = 0; b < c.length; b++) k = m.is(a.range, parseFloat(c[b][0].style[g])).toFixed(q),
                    "string" == typeof a.serialization.to[b] ? c[b].data("input", e.append('<input type="hidden" name="' + a.serialization.to[b] + '">').find("input:last").val(k).change(function(a) {
                        a.stopPropagation()
                    })) : !1 == a.serialization.to[b] ? c[b].data("input", {
                        val: function(a) {
                            if ("undefined" != typeof a) this.handle.data("noUiVal", a);
                            else return this.handle.data("noUiVal")
                        },
                        handle: c[b]
                    }) : c[b].data("input", a.serialization.to[b].data("handleNR", b).val(k).change(function() {
                        var a = [null, null];
                        a[f(this).data("handleNR")] = f(this).val();
                        e.val(a)
                    }));
                    f(this).data("setup", {
                        settings: a,
                        handles: c,
                        pos: g,
                        res: q
                    })
                })
            },
            val: function(a) {
                if ("undefined" !== typeof a) {
                    var e = "number" == typeof a ? [a] : a;
                    return this.each(function() {
                        for (var a = f(this).data("setup"), b = 0; b < a.handles.length; b++) if (null != e[b]) {
                            var c = s(m.to(a.settings.range, e[b]), f(this), a.handles[b]);
                            a.handles[b].css(a.pos, c + "%").data("input").val(m.is(a.settings.range, c).toFixed(a.res))
                        }
                    })
                }
                a = f(this).data("setup").handles;
                for (var c = [], g = 0; g < a.length; g++) c.push(parseFloat(a[g].data("input").val()));
			
                return 1 == c.length ? c[0] : c
            },
            disabled: function() {
                return r ? f(this).addClass("disabled") : f(this).removeClass("disabled")
            }
        };
        var v = jQuery.fn.val;
        jQuery.fn.val = function() {
            return this.data("_isnS_") ? methods.val.apply(this, arguments) : v.apply(this, arguments)
        };
        return "disabled" == n ? methods.disabled.apply(this) : methods.create.apply(this)
    }
})(jQuery);