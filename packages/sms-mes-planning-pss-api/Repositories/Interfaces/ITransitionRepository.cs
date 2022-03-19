using System.Collections.Generic;
using sms_mes_planning_pss_api.Models;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface ITransitionRepository
    {
        IEnumerable<Transition> GetAllTransitions();
        Transition GetTransitionById(int TransitionId);
        Transition GetTransitionByData(NewTransition transition);
        IEnumerable<Transition> GetTransitionsByAttributeId(int AttributeId);
        bool AddNewTransition(NewTransition transition);
        bool UpdateTransition(NewTransition transition);
    }
}
