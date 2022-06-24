function childIssueShowOrHide(parentTR)
{
  var childlen = slaTRs.filter(function(index){ 
    return index >= (parentTR.attr('cs') - 0) && index <= (parentTR.attr('ce') - 0); 
  });
  
  if (childlen.is(":visible"))
  {
    parentTR.removeClass("expand").addClass("collapse");
    childlen.hide("fast").filter(".haschild").removeClass("expand").addClass("collapse");
  }
  else
  {
    parentTR.removeClass("collapse").addClass("expand");
    childlen.filter('.idnt-' + (parentTR.attr('rank') - 0 + 1)).show("fast");
  }
}

function seletedTreeOpen()
{
  var targetParents = slaTRs.filter("tr:has(td.checkbox > input:checked)");
  for (var i = 0; i < targetParents.length; i++)
  {
    var parentTR = targetParents.eq(i);
    if (!parentTR.hasClass("haschild"))
    {
      continue;
    }    

    //show
    var childlen = slaTRs.filter(function(index){ 
      return index >= (parentTR.attr('cs') - 0) && index <= (parentTR.attr('ce') - 0); 
    });
    childlen.show().filter(".haschild").removeClass("collapse").addClass("expand");
    parentTR.removeClass("collapse").addClass("expand");
  }
}

function seletedTreeClose()
{
  var targetParents = slaTRs.filter("tr:has(td.checkbox > input:checked)");
  for (var i = 0; i < targetParents.length; i++)
  {
    var parentTR = targetParents.eq(i);
    if (!parentTR.hasClass("haschild"))
    {
      continue;
    }
    
    //hide
    var childlen = slaTRs.filter(function(index){ 
      return index >= (parentTR.attr('cs') - 0) && index <= (parentTR.attr('ce') - 0); 
    });
    childlen.hide().filter(".haschild").removeClass("expand").addClass("collapse");
    parentTR.removeClass("expand").addClass("collapse");
  }
}

function allExpandNext()
{
  var parentTR = slaTRs.filter("tr:has(td.checkbox > input:checked)");
  if (parentTR.length != 1)
  {
    exit;
  }
  if (!parentTR.hasClass("haschild"))
  {
    exit;
  }
  
  for (var rank = 0; rank <= (parentTR.attr("rank") - 0); rank++)
  {  
    //show
    slaTRs.filter("tr[rank='" + rank + "'].haschild.collapse").each(function(){
      childIssueShowOrHide($(this));
    });
  }
}

$(document).ready(function()
{
  //set toggle event
  slaTRs = $("table.list > tbody > tr");
  slaTRs.find("td.subject > span.treearrow").click(function()
  {
    childIssueShowOrHide($(this).parent().parent());
    return false;
  });
 
  //all expand
  $("a.subtask_all_expand").click(function(){
    slaTRs.show().filter(".haschild").removeClass("collapse").addClass("expand");
    
    //for debug
    if (slaTRs.filter("tr:visible").length != slaTRs.length) alert("NG");
    
    return false;
  });
  
  //all collapese
  $("a.subtask_all_collapse").click(function(){
    slaTRs.filter(".idnt").hide();
    slaTRs.filter(".haschild").removeClass("expand").addClass("collapse");
    return false;
  });
  
  //link move
  $("div.accordion_control").insertAfter("#issue_tree > p");
});
