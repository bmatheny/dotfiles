// PLUGIN_INFO//{{{
var PLUGIN_INFO =
<VimperatorPlugin>
  <name>calc</name>
  <description>Calculator</description>
  <author mail="calc@mobocracy.net" homepage="http://mobocracy.net">Blake Matheny</author>
  <version>0.1</version>
  <license>GPL</license>
  <minVersion>1.2</minVersion>
  <maxVersion>2.1</maxVersion>
  <updateURL>http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/calc.js</updateURL>
  <require type="plugin">_libly.js</require>
  <detail><![CDATA[

== Command ==
Usage:
  :calc expression
    Evaluate the math expression

  ]]></detail>
</VimperatorPlugin>;
//}}}
//
(
  function()
  {
    commands.addUserCommand(
      ['calc','calc'],
      'Calculate Math Expression',
      function(args)
      {
        try
        {
	  var expr = eval(args.literalArg);
	  liberator.echo(expr);
        }
        catch(e)
        {
          liberator.echoerr(e);
        }
      },
      {
        literal: 0
      },
      true
    );
  }
)();
