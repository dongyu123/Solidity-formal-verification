#pragma once

#include <libsolidity/ast/ASTVisitor.h>

namespace solidity
{
namespace frontend
{
/**
 * Helper class for collecting statistics about the AST
 */
class ASTBoogieStats : public ASTConstVisitor
{
private:
	bool m_hasModifiesSpecs;
	bool m_hasEventSpecs;

	std::list<ContractDefinition const*> m_allContracts;

	bool hasDocTag(StructurallyDocumentedAnnotation const& _annot, std::string _tag) const;

public:
	ASTBoogieStats() : m_hasModifiesSpecs(false), m_hasEventSpecs(false) {}
	bool hasModifiesSpecs() const { return m_hasModifiesSpecs; }
	bool hasEventSpecs() const { return m_hasEventSpecs; }
	std::list<ContractDefinition const*> const& allContracts() const { return m_allContracts; }

	bool visit(ContractDefinition const& _node) override;
	bool visit(FunctionDefinition const& _node) override;
	bool visit(EventDefinition const& _node) override;
};

}
}
