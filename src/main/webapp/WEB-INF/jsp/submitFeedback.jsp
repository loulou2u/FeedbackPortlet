<%--

    Licensed to Apereo under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Apereo licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<jsp:directive.include file="/WEB-INF/jsp/include.jsp"/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">

<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">

<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

<script src="<rs:resourceURL value="/rs/jquery/1.11.0/jquery-1.11.0.min.js"/>" type="text/javascript"></script>
<!-- <script src="/ResourceServingWebapp/rs/jquery-migrate/1.2.1/jquery-migrate-1.2.1.min.js" type="text/javascript"></script> -->
<script src="<c:url value="/js/twitlimit-0.2.0.compressed.js"/>" type="text/javascript"></script>

<c:set var="n"><portlet:namespace/></c:set>

<portlet:actionURL var="postUrl"/>

<div>

<form:form action="${postUrl}" modelAttribute="submitFeedbackForm">
    <spring:bind path="prefs.*">
        <c:if test="${status.error}">
        <div id="${n}error-message" role="alert" style="display:none">
            <p><form:errors path="feedback"/></p>
        </div>
        </c:if>
    </spring:bind>

    <div aria-labelledby="question" role="radiogroup" id="${n}answer">
        <label id="question"><spring:message code="feedback.form.question"/></label>
        <div>
            <label class="mdl-radio mdl-js-radio" for="yes">
                <input class="mdl-radio__button" role="radio" aria-checked="false" id="yes" name="like" type="radio" value="YES">
                <span class="mdl-radio__label"><spring:message code="feedback.answer.yes"/></span>
            </label>
        </div>
        <div>
            <label class="mdl-radio mdl-js-radio" for="no">
                <input class="mdl-radio__button" role="radio" aria-checked="false" id="no" name="like" type="radio" value="NO">
                <span class="mdl-radio__label"><spring:message code="feedback.answer.no"/></span>
            </label>
        </div>
        <div>
            <label class="mdl-radio mdl-js-radio" for="maybe">
                <input class="mdl-radio__button" role="radio" aria-checked="false" id="maybe" name="like" type="radio" value="MAYBE">
                <span class="mdl-radio__label"><spring:message code="feedback.answer.maybe"/></span>
            </label>
        </div>
    </div>

    <p class="mdl-textfield mdl-js-textfield">
        <textarea class="mdl-textfield__input" id="${n}feedback" name="feedback" rows="${feedbackRows}" style="width:${feedbackWidth}"></textarea>

        <!-- margin-bottom: 0px works around a conflict with the .portlet-form-field-label Bootstrap class. -->
        <label class="mdl-textfield__label" style="margin-bottom: 0px;width:${feedbackWidth}" for="${n}feedback"><spring:message code="feedback.form.suggestion"/></label>
    </p>

     <div id="${n}limit" style="margin-bottom: 12px;"></div>

     <p>
        <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="${n}anonymous">
            <input class="mdl-checkbox__input" type="checkbox" id="${n}anonymous" name="anonymous" value="true"/>
            <span class="mdl-checkbox__label"><spring:message code="feedback.form.anonymous"/></span>
        </label>
     </p>

     <input id="${n}useragentstring" type="hidden" name="useragent"/>
     <input id="${n}feedbacktabname" type="hidden" name="tabname"/>

     <p>
         <input type="submit" id="${n}submitfeedback" disabled="disabled" aria-disabled="true" value="<spring:message code="feedback.form.submit"/>">
     </p>

</form:form>
</div>

<script type="text/javascript"><rs:compressJs>
   // Enable submitFeedback work here only on Mobile
    var $ = up.jQuery;
    $(document).bind("pageinit", function (e) {
        var $page = $(e.target);
        $page.find("input:radio[name=like]").change(function () {
            $(this).checkboxradio("refresh");
            $page.find("input:radio[name=like]").each(function (index, element) {
                var $radio = $(this);
                var $label = $radio.next();
                if ($label.hasClass("ui-radio-on")) {

                    if ($('#${n}submitfeedback').attr('disabled')) {
                        $('#${n}submitfeedback').removeAttr('disabled');
                    }

                    if ($('#${n}submitfeedback').attr('aria-disabled')) {
                        $('#${n}submitfeedback').removeAttr('aria-disabled');
                    }

                    if ($('#${n}submitfeedback').prop('disabled')) {
                        $('#${n}submitfeedback').prop('disabled', false);
                    }
                }
            });
        });
    });

    var ${n} = {};

    ${n}.jQuery = jQuery.noConflict(true);

    ${n}.jQuery(function(){

        var $ = ${n}.jQuery;

        $('#${n}feedback').twitLimit({
            limit: ${feedbackMaxChars},
            message: '<spring:message code="feedback.form.charactersremaining" arguments="%1"/>',
            counterElem: '#${n}limit',
            allowNegative: false
        });

        document.getElementById('${n}useragentstring').value = navigator.userAgent;

        $("#${n}error-message").slideDown(500);

        $('#submitFeedbackForm').submit(function (){
            // disable submit
            $('input[type=submit]', this).attr('disabled','disabled');
            $('#${n}submitfeedback').attr('disabled','disabled');
        });

       // Enable submitFeedback work here only on Desktop
       $("#${n}answer input:radio, #${n}answer label").click(function (){
            // Toggle aria-checked attributes when a radio button is selected
            $(this).attr('aria-checked', 'true');

            if (Object.is($(this).attr('id'), 'yes')) {
                $('#no').attr('aria-checked', 'false');
                $('#maybe').attr('aria-checked', 'false');
            }else if (Object.is($(this).attr('id'), 'no')) {
                $('#yes').attr('aria-checked', 'false');
                $('#maybe').attr('aria-checked', 'false');
            }else if (Object.is($(this).attr('id'), 'maybe')) {
                $('#yes').attr('aria-checked', 'false');
                $('#no').attr('aria-checked', 'false');
            }

            if ($('#${n}submitfeedback').attr('disabled')) $('#${n}submitfeedback').removeAttr('disabled');
            if ($('#${n}submitfeedback').attr('aria-disabled')) $('#${n}submitfeedback').removeAttr('aria-disabled');
            if ($('#${n}submitfeedback').prop('disabled')) $('#${n}submitfeedback').prop('disabled', false);
        });

        // check to see if a tab name parameter was submitted
        if ('${ requestScope.tabName }' != null && '${ requestScope.tabName }' != '') {
            document.getElementById('${n}feedbacktabname').value = '${requestScope.tabName }';
        // uPortal 2 tab name
        } else if (document.getElementById('tabName') != null) {
            document.getElementById('${n}feedbacktabname').value = $("#tabName").text();
        // uPortal 3 tab name
        } else if (document.getElementById('portalPageBodyTitle') != null) {
            document.getElementById('${n}feedbacktabname').value = $("#portalPageBodyTitle").text();
        }

    });

</rs:compressJs></script>
