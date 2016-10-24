function getParentIssue(startPos, rank, sameTreeOnly)
{
  if (sameTreeOnly)
  {
    if (rank > 0 &&
        !slaTRs.eq(startPos.val + 1).hasClass("idnt-" + rank) &&
        !slaTRs.eq(startPos.val + 1).hasClass("idnt-" + (rank + 1)))
    {
      //skip because other tree
      return $();
    }
  }
  
  //find potential parent
  var issuesSelector = "table.list > tbody > tr";
  var rankAttr = rank <= 0 ? ":not(.idnt)" : "tr.idnt-" + rank;
  var nextAttr = "tr.idnt-" + (rank + 1 - 0);
  var selectorP = ":gt(" + startPos.val + ")" + rankAttr;
  var selectorC = nextAttr + ":first";
  var pp = $(issuesSelector + selectorP + " + " + selectorC);
  if (pp.size() != 1)
  {
    return $();
  }
  
  //get parent
  startPos.val = pp.index() - 1;
  return slaTRs.filter(function(index){ 
    return index == pp.index() - 1; 
  });
}

function getChildIssues(startPos, rank)
{
  //find first child
  var nextAttr = ".idnt-" + (rank - 0 + 1);
  var selectorFirst = ":gt(" + startPos.val + ")" + nextAttr + ":first";
  var startIdx = slaTRs.filter(selectorFirst).index();
  if (startIdx <= 0)
  {
    return $();
  }
  
  //find last child
  var cc = startIdx;
  var rankCount = rank + 1;
  var endIdx;
  do
  {
    if (slaTRs.eq(cc).is('.idnt-' + rankCount))
    {
      endIdx = cc++;
    }
    else if (slaTRs.eq(cc).is('.idnt-' + (rankCount - 0 + 1)))
    {
      endIdx = cc++;
      rankCount++;
    }
    else if (slaTRs.eq(cc).is('.idnt') && (rankCount > (rank + 1)))
    {
      rankCount--;
    }
    else
    {
      break;
    }
  }
  while (cc < slaTRsSize)
  
  startPos.val = endIdx;
  return slaTRs.filter(function(index){ return index >= startIdx && index <= endIdx; });
}

function addRangeIndex(parentTR, childlen, rank)
{
  parentTR.attr('cs', childlen.filter("tr:first").index()).attr('ce', childlen.filter("tr:last").index()).attr('rank', rank);
}

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

function setAccordion(parentPos, rank, isHiding, sameTreeOnly)
{
  var parentTR = getParentIssue(parentPos, rank, sameTreeOnly);
  if (parentTR.size() != 1)
  {
    return false;
  }
  else if (parentTR.hasClass("haschild"))
  {
    //search exit or skip
    return !sameTreeOnly;
  }
  parentTR.addClass("haschild").addClass(isHiding ? "collapse" : "expand").find("td.subject > a").before('<span class="treearrow" />');
  
  var childlen = getChildIssues(parentPos, rank);
  addRangeIndex(parentTR, childlen, rank);
  parentTR.find('td.subject > span.treearrow').click(function()
  {
    childIssueShowOrHide($(this).parent().parent());
    return false;
  });
  if (isHiding)
  {
    childlen.hide();
  }
  
  //make next rank
  if (sameTreeOnly)
  {
    parentTR.find("td.subject > span.treearrow").one('click', function(){
      var parentTR = $(this).parent().parent();
      var parentFound = false;
      var parentPos = { val: 0 };
      parentPos.val = parentTR.index();
      do
      {
        parentFound = setAccordion(parentPos, rank + 1, true, true);
      }
      while(parentFound);
    });
  }
  
  //do next
  return true;
}

function seletedTreeOpen()
{
  var targetParents = slaTRs.filter("tr:has(td.checkbox > input:checked)");
  for (var i = 0; i < targetParents.size(); i++)
  {
    var parentTR = targetParents.eq(i);
    if (!parentTR.hasClass("haschild"))
    {
      continue;
    }
    
    //make rank
    for (var rank = (parentTR.attr("rank") - 0 + 1); rank < 10; rank++)
    {
      var parentFound = false;
      var parentPos = { val: 0 };
      parentPos.val = parentTR.index();
      do
      {
        parentFound = setAccordion(parentPos, rank, false, false);
      }
      while(parentFound && parentPos.val < (parentTR.attr('ce') - 0));
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
  for (var i = 0; i < targetParents.size(); i++)
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