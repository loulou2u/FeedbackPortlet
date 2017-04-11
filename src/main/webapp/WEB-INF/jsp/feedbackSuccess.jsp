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

<link href="<c:url value="/css/feedback.css"/>" type="text/css" rel="stylesheet"/>

<div class="feedback-portlet bootstrap-styles-by-6">
    <h3><spring:message code="feedback.success.title"/></h3>

    <p><spring:message code="feedback.success.message"/></p>

    <p><a class="btn btn-default" href="<portlet:renderURL/>" role="button"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> <spring:message code="feedback.success.more"/></a></p>
</div>
