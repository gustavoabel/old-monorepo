using System;
using System.Collections.Generic;
using System.Linq;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class TransitionRepository : ITransitionRepository
    {
        private readonly IBaseRepository _baseRepository;

        public TransitionRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<Transition> GetAllTransitions()
        {
            try
            {
                IEnumerable<Transition> Result = _baseRepository.GetQueryResult<Transition>(
                    TransitionQuery.GetAllTransitions
                );

                return Result;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return default;
            }
        }
        public Transition GetTransitionById(int TransitionId)
        {
            try
            {
                Transition Result = _baseRepository.GetQueryResult<Transition>(
                    TransitionQuery.GetTransitionById, 
                    new { TransitionId = TransitionId }
                ).SingleOrDefault();

                return Result;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return default;
            }
        }
        public Transition GetTransitionByData(NewTransition transition)
        {
            try
            {
                Transition Result = _baseRepository.GetQueryResult<Transition>(
                    TransitionQuery.GetTransitionByData, 
                    new {
                        Attribute = transition.Attribute,
                        From = transition.From,
                        To = transition.To
                    }
                ).SingleOrDefault();

                return Result;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return default;
            }
        }
        public IEnumerable<Transition> GetTransitionsByAttributeId(int AttributeId)
        {
            try
            {
                IEnumerable<Transition> Result = _baseRepository.GetQueryResult<Transition>(
                    TransitionQuery.GetTransitionsByAttributeId, 
                    new { MaterialAttributeDefinitionId = AttributeId }
                );

                return Result;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return default;
            }
        }
        public bool AddNewTransition(NewTransition transition)
        {
            try
            {
                _baseRepository.RunQuery(TransitionQuery.AddNewTransition, transition);
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return false;
            }
        }
        public bool UpdateTransition(NewTransition transition)
        {
            try
            {
                _baseRepository.RunQuery(TransitionQuery.AddNewTransition, transition);
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return false;
            }
        }
    }
}