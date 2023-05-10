# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal && monoidal (co)closed categories
#
# Implementations
#

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsRigidSymmetricCoclosedMonoidalCategory  = @Concatenation( [ 
"InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
"MorphismToCoBidualWithGivenCoBidual"
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsSymmetricCoclosedMonoidalCategory );

InstallTrueMethod( IsSymmetricCoclosedMonoidalCategory, IsRigidSymmetricCoclosedMonoidalCategory );
