<%inherit file="/base.mako"/>
<%namespace file="/message.mako" import="render_msg" />
<%namespace file="/sorting_base.mako" import="get_sort_url, get_css" />
<%namespace file="/page_base.mako" import="get_pages" />

%if message:
    ${render_msg( message, 'done' )}
%endif

${get_css()}

<!--jobs_specified_month_all.mako-->
<div class="toolForm">
    <div class="toolFormBody">
        <table id="formHeader">
            <tr>
                <td>
                    ${get_pages( sort_id, order, page_specs, 'jobs', 'specified_month_all' )}
                </td>
                <td>
                    <h4 align="center">Jobs for ${month_label}&nbsp;${year_label}</h4>
                    <h5 align="center">Click job count to see the day's details</h5>
                </td>
                <td id="entry_form" align="right">
                    <form method="post" controller="jobs" action="specified_month_all">
                        <input type="hidden" value=${sort_id} name="sort_id">
                        <input type="hidden" value=${order} name="order">
                        Max items:
                        <input id="entries_edit"
                               type="text"
                               name="entries"
                               value="${page_specs.entries}">
                        </input>
                        <button id="entry_submit">Go</button>
                    </form>
                </td>
            </tr>
        </table>
        <table align="center" width="60%" class="colored">
            %if len( jobs ) == 0:
                <tr><td colspan="5">There are no jobs for ${month_label}&nbsp;${year_label}</td></tr>
            %else:
                <tr class="header">
                    
                    <td>Day</td>
                    <td>
                        ${get_sort_url(sort_id, order, 'date', 'jobs', 'specified_month_all', 'Date')}
                        <span class='dir_arrow date'>${arrow}</span>
                    </td>
                    %if is_user_jobs_only:
    					<td>
                            ${get_sort_url(sort_id, order, 'total_jobs', 'jobs', 'specified_month_all', 'User Jobs')}
                            <span class='dir_arrow total_jobs'>${arrow}</span>
                        </td>
					%else:
	                    <td>
                            ${get_sort_url(sort_id, order, 'total_jobs', 'jobs', 'specified_month_all', 'User and Monitor Jobs')}
                            <span class='dir_arrow total_jobs'>${arrow}</span>
                        </td>
	                %endif
                </tr>
                <% 
                   ctr = 0
                   entries = 1
                %>
                %for job in jobs:
                    %if entries > page_specs.entries:
                        <%break%>
                    %endif
                    
                    %if ctr % 2 == 1:
                        <tr class="odd_row">
                    %else:
                        <tr class="tr">
                    %endif
                        <td>${job[0]}</td>
                        <td>${month_label}&nbsp;${job[1]},&nbsp;${year_label}</td>
                        <td><a href="${h.url_for( controller='jobs', action='specified_date_handler', specified_date=job[3], webapp='reports', sort_id='default', order='default' )}">${job[2]}</a></td>
                    </tr>
                    <% 
                       ctr += 1
                       entries += 1
                    %>
                %endfor
            %endif
        </table>
    </div>
</div>
<!--End jobs_specified_month_all.mako-->
