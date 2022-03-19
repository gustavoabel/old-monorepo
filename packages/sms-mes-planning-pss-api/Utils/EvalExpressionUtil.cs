using Jint;
using Z.Expressions;

namespace sms_mes_planning_pss_api.Utils
{
    public static class EvalExpressionUtil
    {
        public static T EvalTypescriptExpression<T>(string code, string key, object value)
        {
            return (T)new Engine()
                .SetValue(key, value)
                .Execute(code)
                .GetCompletionValue()
                .ToObject();
        }

        public static T EvalCSharpExpression<T>(string code, string key, object value)
        {
            return Eval.Execute<T>(code, new { key = value });
        }
    }
}
