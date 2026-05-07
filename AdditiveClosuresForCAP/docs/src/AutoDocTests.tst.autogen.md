
```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> true
true

julia> zz = HomalgRingOfIntegers( );

julia> Zmat = CategoryOfRows( zz )
Rows( Z )

julia> Display( Zmat )
A CAP category with name Rows( Z ):

83 primitive operations were used to derive 430 operations for this category which algorithmically
* IsEquippedWithHomomorphismStructure
* IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
* IsPreAbelianCategory
* IsRigidSymmetricClosedMonoidalCategory
* IsRigidSymmetricCoclosedMonoidalCategory
* IsAdditiveMonoidalCategory
and furthermore mathematically
* IsSkeletalCategory
* IsStrictMonoidalCategory

julia> mat = HomalgMatrix(
                       [ [  -36,   18,  -80,  -54,   28 ],
                         [   90,  -45,  140,   45,  -40 ],
                         [  -24,   12,  -32,   -4,    8 ],
                         [   -6,    3,   -4,    5,    0 ] ], 4, 5, zz );

julia> mor = mat / Zmat
<A morphism in Rows( Z )>

julia> split_epi = CoimageProjection( mor )
<A morphism in Rows( Z )>

julia> IsSplitEpimorphism( split_epi )
true

julia> split_mono = ImageEmbedding( mor )
<A morphism in Rows( Z )>

julia> IsSplitMonomorphism( split_mono )
true

julia> epimono = MorphismFromCoimageToImage( mor )
<A morphism in Rows( Z )>

julia> IsEpimorphism( epimono )
true

julia> IsMonomorphism( epimono )
true

julia> LiftAlongMonomorphism( split_mono, AstrictionToCoimage( mor ) ) == epimono
true

julia> ColiftAlongEpimorphism( split_epi, CoastrictionToImage( mor ) ) == epimono
true

julia> PreCompose( [ split_epi, epimono, split_mono ] ) == mor
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> S = HomalgRingOfIntegers();

julia> rows = CategoryOfRows( S )
Rows( Z )

julia> obj1 = CategoryOfRowsObject( 2, rows )
<A row module over Z of rank 2>

julia> obj2 = CategoryOfRowsObject( 8, rows )
<A row module over Z of rank 8>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> obj3 = CategoryOfRowsObject( 1, rows )
<A row module over Z of rank 1>

julia> IsWellDefined( obj1 )
true

julia> obj4 = CategoryOfRowsObject( 2, rows )
<A row module over Z of rank 2>

julia> mor = CategoryOfRowsMorphism( obj3, HomalgMatrix( [[1,2]], 1, 2, S ), obj4 )
<A morphism in Rows( Z )>

julia> IsWellDefined( mor )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> Length( AdditiveGenerators( rows ) )
1

julia> ZeroObject( rows )
<A row module over Z of rank 0>

julia> obj5 = CategoryOfRowsObject( 2, rows )
<A row module over Z of rank 2>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> obj6 = CategoryOfRowsObject( 1, rows )
<A row module over Z of rank 1>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> directSum = DirectSum( [ obj5, obj6 ] )
<A row module over Z of rank 3>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> i1 = InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 )
<A morphism in Rows( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> i2 = InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 )
<A morphism in Rows( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> proj1 = ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 )
<A morphism in Rows( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> proj2 = ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 )
<A morphism in Rows( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> mor2 = IdentityMorphism( obj6 )
<A morphism in Rows( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> source = CategoryOfRowsObject( 1, rows )
<A row module over Z of rank 1>

julia> range = CategoryOfRowsObject( 2, rows )
<A row module over Z of rank 2>

julia> mor = CategoryOfRowsMorphism( source, HomalgMatrix( [[ 2, 3 ]], 1, 2, S ), range )
<A morphism in Rows( Z )>

julia> colift = Colift( mor2, mor )
<A morphism in Rows( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> S = HomalgRingOfIntegers();

julia> cols = CategoryOfColumns( S )
Columns( Z )

julia> obj1 = CategoryOfColumnsObject( 2, cols )
<A column module over Z of rank 2>

julia> obj2 = CategoryOfColumnsObject( 8, cols )
<A column module over Z of rank 8>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> obj3 = CategoryOfColumnsObject( 1, cols )
<A column module over Z of rank 1>

julia> IsWellDefined( obj1 )
true

julia> obj4 = CategoryOfColumnsObject( 2, cols )
<A column module over Z of rank 2>

julia> mor = CategoryOfColumnsMorphism( obj3, HomalgMatrix( [[1],[2]], 2, 1, S ), obj4 )
<A morphism in Columns( Z )>

julia> IsWellDefined( mor )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> ZeroObject( cols )
<A column module over Z of rank 0>

julia> obj5 = CategoryOfColumnsObject( 2, cols )
<A column module over Z of rank 2>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> obj6 = CategoryOfColumnsObject( 1, cols )
<A column module over Z of rank 1>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> directSum = DirectSum( [ obj5, obj6 ] )
<A column module over Z of rank 3>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> i1 = InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 )
<A morphism in Columns( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> i2 = InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 )
<A morphism in Columns( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> proj1 = ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 )
<A morphism in Columns( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> proj2 = ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 )
<A morphism in Columns( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> mor2 = IdentityMorphism( obj6 )
<A morphism in Columns( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> source = CategoryOfColumnsObject( 1, cols )
<A column module over Z of rank 1>

julia> range = CategoryOfColumnsObject( 2, cols )
<A column module over Z of rank 2>

julia> mor = CategoryOfColumnsMorphism( source, HomalgMatrix( [[ 2 ], [ 3 ]], 2, 1, S ), range )
<A morphism in Columns( Z )>

julia> colift = Colift( mor2, mor )
<A morphism in Columns( Z )>

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> Q = HomalgFieldOfRationals();

julia> RowsQ = CategoryOfRows( Q );

julia> a = 3/RowsQ;

julia> b = 4/RowsQ;

julia> IsProjective( a )
true

julia> homalg_matrix = HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                          [ 0, 1, 0, -1 ],
                                          [ -1, 0, 2, 1 ] ], 3, 4, Q );

julia> alpha = homalg_matrix/RowsQ;

julia> homalg_matrix = HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                          [ 0, 1, 0, -1 ],
                                          [ -1, 0, 2, 1 ] ], 3, 4, Q );

julia> beta = homalg_matrix/RowsQ;

julia> IsWellDefined( CokernelObject( alpha ) )
true

julia> c = CokernelProjection( alpha );

julia> gamma = UniversalMorphismIntoDirectSum( [ c, c ] );

julia> colift = CokernelColift( alpha, gamma );

julia> IsEqualForMorphisms( PreCompose( c, colift ), gamma )
true

julia> FiberProduct( alpha, beta );

julia> F = FiberProduct( alpha, beta );

julia> IsWellDefined( F )
true

julia> IsWellDefined( ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 ) )
true

julia> IsWellDefined( Pushout( alpha, beta ) )
true

julia> i1 = InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );

julia> i2 = InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );

julia> u = UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );

julia> KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) == IdentityMorphism( 3/RowsQ )
true

julia> IsZeroForMorphisms( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) )
true

julia> DirectProductFunctorial( [ u, u ] ) == DirectSumFunctorial( [ u, u ] )
true

julia> CoproductFunctorial( [ u, u ] ) == DirectSumFunctorial( [ u, u ] )
true

julia> IsCongruentForMorphisms(
            FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ),
            IdentityMorphism( FiberProduct( [ u, u ] ) )
        )
true

julia> IsCongruentForMorphisms(
            PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ),
            IdentityMorphism( Pushout( [ u, u ] ) )
        )
true

julia> IsCongruentForMorphisms( ((1/2) / Q) * alpha, alpha * ((1/2) / Q) )
true

julia> RankOfObject( HomomorphismStructureOnObjects( a, b ) ) == RankOfObject( a ) * RankOfObject( b )
true

julia> IsCongruentForMorphisms(
            PreCompose( [ u, DualOnMorphisms( i1 ), DualOnMorphisms( alpha ) ] ),
            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( u ), Source( alpha ),
                 PreCompose(
                     InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( DualOnMorphisms( i1 ) ),
                     HomomorphismStructureOnMorphisms( u, DualOnMorphisms( alpha ) )
                 )
            )
        )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> Q = HomalgFieldOfRationals();

julia> ColsQ = CategoryOfColumns( Q );

julia> a = 3/ColsQ;

julia> b = 4/ColsQ;

julia> IsProjective( a )
true

julia> homalg_matrix = HomalgMatrix( [ [ 1, 0, 0, 0 ],
                                          [ 0, 1, 0, -1 ],
                                          [ -1, 0, 2, 1 ] ], 3, 4, Q );

julia> homalg_matrix = TransposedMatrix( homalg_matrix );

julia> alpha = homalg_matrix/ColsQ;

julia> homalg_matrix = HomalgMatrix( [ [ 1, 1, 0, 0 ],
                                          [ 0, 1, 0, -1 ],
                                          [ -1, 0, 2, 1 ] ], 3, 4, Q );

julia> homalg_matrix = TransposedMatrix( homalg_matrix );

julia> beta = homalg_matrix/ColsQ;

julia> IsWellDefined( CokernelObject( alpha ) )
true

julia> c = CokernelProjection( alpha );

julia> gamma = UniversalMorphismIntoDirectSum( [ c, c ] );

julia> colift = CokernelColift( alpha, gamma );

julia> IsEqualForMorphisms( PreCompose( c, colift ), gamma )
true

julia> FiberProduct( alpha, beta );

julia> F = FiberProduct( alpha, beta );

julia> IsWellDefined( F )
true

julia> IsWellDefined( ProjectionInFactorOfFiberProduct( [ alpha, beta ], 1 ) )
true

julia> IsWellDefined( Pushout( alpha, beta ) )
true

julia> i1 = InjectionOfCofactorOfPushout( [ alpha, beta ], 1 );

julia> i2 = InjectionOfCofactorOfPushout( [ alpha, beta ], 2 );

julia> u = UniversalMorphismFromDirectSum( [ b, b ], [ i1, i2 ] );

julia> KernelObjectFunctorial( u, IdentityMorphism( Source( u ) ), u ) == IdentityMorphism( 3/ColsQ )
true

julia> IsZeroForMorphisms( CokernelObjectFunctorial( u, IdentityMorphism( Range( u ) ), u ) )
true

julia> DirectProductFunctorial( [ u, u ] ) == DirectSumFunctorial( [ u, u ] )
true

julia> CoproductFunctorial( [ u, u ] ) == DirectSumFunctorial( [ u, u ] )
true

julia> IsCongruentForMorphisms(
            FiberProductFunctorial( [ u, u ], [ IdentityMorphism( Source( u ) ), IdentityMorphism( Source( u ) ) ], [ u, u ] ),
            IdentityMorphism( FiberProduct( [ u, u ] ) )
        )
true

julia> IsCongruentForMorphisms(
            PushoutFunctorial( [ u, u ], [ IdentityMorphism( Range( u ) ), IdentityMorphism( Range( u ) ) ], [ u, u ] ),
            IdentityMorphism( Pushout( [ u, u ] ) )
        )
true

julia> IsCongruentForMorphisms( ((1/2) / Q) * alpha, alpha * ((1/2) / Q) )
true

julia> RankOfObject( HomomorphismStructureOnObjects( a, b ) ) == RankOfObject( a ) * RankOfObject( b )
true

julia> IsCongruentForMorphisms(
            PreCompose( [ u, DualOnMorphisms( i1 ), DualOnMorphisms( alpha ) ] ),
            InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( Source( u ), Source( alpha ),
                 PreCompose(
                     InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( DualOnMorphisms( i1 ) ),
                     HomomorphismStructureOnMorphisms( u, DualOnMorphisms( alpha ) )
                 )
            )
        )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> true
true

julia> Q = HomalgFieldOfRationals();

julia> R = RingAsCategory( Q )
RingAsCategory( Q )

julia> A = AdditiveClosure( R )
AdditiveClosure( RingAsCategory( Q ) )

julia> u = TensorUnit( A )
<An object in AdditiveClosure( RingAsCategory( Q ) ) defined by 1 underlying objects>

julia> mor1 = [ [ 1 / R, 2 / R ] ] / A
<A morphism in AdditiveClosure( RingAsCategory( Q ) ) defined by a 1 x 2 matrix of underlying morphisms>

julia> mor2 = [ [ 3 / R, 4 / R ] ] / A
<A morphism in AdditiveClosure( RingAsCategory( Q ) ) defined by a 1 x 2 matrix of underlying morphisms>

julia> T = TensorProduct( mor1, mor2 )
<A morphism in AdditiveClosure( RingAsCategory( Q ) ) defined by a 1 x 4 matrix of underlying morphisms>

julia> Display( T )
A 1 x 4 matrix with entries in RingAsCategory( Q )

[1,1]: <3>
[1,2]: <4>
[1,3]: <6>
[1,4]: <8>

julia> Display( Range( T ) )
A formal direct sum consisting of 4 objects.
*
*
*
*

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> true
true

julia> T = TerminalCategoryWithMultipleObjects( )
TerminalCategoryWithMultipleObjects( )

julia> A = "A" / T
<An object in TerminalCategoryWithMultipleObjects( )>

julia> B = "B" / T
<An object in TerminalCategoryWithMultipleObjects( )>

julia> AT = AdditiveClosure( T )
AdditiveClosure( TerminalCategoryWithMultipleObjects( ) )

julia> ABAA = [ A, B, A, A ] / AT
<An object in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by 4 underlying objects>

julia> BAB = [ B, A, B ] / AT
<An object in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by 3 underlying objects>

julia> AB = [ A, B ] / AT
<An object in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by 2 underlying objects>

julia> mor_AB = MorphismConstructor( A, "A -> B", B )
<A morphism in TerminalCategoryWithMultipleObjects( )>

julia> mor_BA = MorphismConstructor( B, "B -> A", A )
<A morphism in TerminalCategoryWithMultipleObjects( )>

julia> id_A = IdentityMorphism( A )
<A morphism in TerminalCategoryWithMultipleObjects( )>

julia> id_B = IdentityMorphism( B )
<A morphism in TerminalCategoryWithMultipleObjects( )>

julia> alpha = MorphismConstructor( ABAA,
          [ [ mor_AB, id_A, mor_AB ],
            [ id_B, mor_BA, id_B ],
            [ mor_AB, id_A, mor_AB ],
            [ mor_AB, id_A, mor_AB ] ],
            BAB )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 4 x 3 matrix of underlying morphisms>

julia> IsWellDefined( alpha )
true

julia> alpha2 = TensorProduct( alpha, alpha )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 16 x 9 matrix of underlying morphisms>

julia> IsWellDefined( alpha2 )
true

julia> IsIsomorphism( alpha2 )
true

julia> left = LeftUnitor( ABAA )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 4 x 4 matrix of underlying morphisms>

julia> IsWellDefined( left )
true

julia> left_inv = LeftUnitorInverse( ABAA )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 4 x 4 matrix of underlying morphisms>

julia> PreCompose( left, left_inv ) == IdentityMorphism( Source( left ) )
true

julia> PreCompose( left_inv, left ) == IdentityMorphism( Range( left ) )
true

julia> right = RightUnitor( BAB )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 3 x 3 matrix of underlying morphisms>

julia> IsWellDefined( right )
true

julia> right_inv = RightUnitorInverse( BAB )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 3 x 3 matrix of underlying morphisms>

julia> PreCompose( right, right_inv ) == IdentityMorphism( Source( right ) )
true

julia> PreCompose( right_inv, right ) == IdentityMorphism( Range( right ) )
true

julia> aslr = AssociatorLeftToRight( AB, BAB, AB )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 12 x 12 matrix of underlying morphisms>

julia> IsWellDefined( aslr )
true

julia> asrl = AssociatorRightToLeft( AB, BAB, AB )
<A morphism in AdditiveClosure( TerminalCategoryWithMultipleObjects( ) ) defined by a 12 x 12 matrix of underlying morphisms>

julia> PreCompose( aslr, asrl ) == IdentityMorphism( Source( aslr ) )
true

julia> PreCompose( asrl, aslr ) == IdentityMorphism( Range( aslr ) )
true

```

```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, MonoidalCategories, LinearAlgebraForCAP, AdditiveClosuresForCAP

julia> true
true

julia> QQ = HomalgFieldOfRationals( );

julia> cols = CategoryOfColumns( QQ );

julia> rows = CategoryOfRows( QQ );

julia> object_constructor =
            ( cat, rank ) -> CreateCapCategoryObjectWithAttributes( cat,
                                                                    Opposite, CategoryOfRowsObject( Opposite( cat ), rank )
            );

julia> modeling_tower_object_constructor =
            ( cat, rank ) -> CreateCapCategoryObjectWithAttributes( ModelingCategory( cat ),
                                                                    RankOfObject, rank
            );

julia> object_datum = ( cat, obj ) -> RankOfObject( Opposite( obj ) );

julia> modeling_tower_object_datum = ( cat, obj ) -> RankOfObject( obj );

julia> morphism_constructor =
            ( cat, source, underlying_matrix, range ) ->
                CreateCapCategoryMorphismWithAttributes(
                    cat,
                    source, range,
                    Opposite, CategoryOfRowsMorphism(
                        Opposite( cat ),
                        Opposite( range ),
                        underlying_matrix,
                        Opposite( source )
                    )
                );

julia> modeling_tower_morphism_constructor =
            ( cat, source, underlying_matrix, range ) ->
                CreateCapCategoryMorphismWithAttributes(
                    ModelingCategory( cat ),
                    source, range,
                    UnderlyingMatrix, underlying_matrix
                );

julia> morphism_datum = ( cat, mor ) -> UnderlyingMatrix( Opposite( mor ) );

julia> modeling_tower_morphism_datum = ( cat, mor ) -> UnderlyingMatrix( mor );

julia> op = ReinterpretationOfCategory( cols, @rec(
            name = @Concatenation( "Opposite( ", Name( rows )," )" ),
            category_filter = WasCreatedAsOppositeCategory,
            category_object_filter = IsCapCategoryOppositeObject,
            category_morphism_filter = IsCapCategoryOppositeMorphism,
            object_constructor = object_constructor,
            object_datum = object_datum,
            morphism_constructor = morphism_constructor,
            morphism_datum = morphism_datum,
            modeling_tower_object_constructor = modeling_tower_object_constructor,
            modeling_tower_object_datum = modeling_tower_object_datum,
            modeling_tower_morphism_constructor = modeling_tower_morphism_constructor,
            modeling_tower_morphism_datum = modeling_tower_morphism_datum,
            only_primitive_operations = true,
        ) )
Opposite( Rows( Q ) )

julia> SetOpposite( op, rows )

julia> source = ObjectConstructor( op, 1 )
<An object in Opposite( Rows( Q ) )>

julia> range = ObjectConstructor( op, 2 )
<An object in Opposite( Rows( Q ) )>

julia> zero = ZeroMorphism( source, range )
<A morphism in Opposite( Rows( Q ) )>

julia> sum = AdditionForMorphisms( zero, zero )
<A morphism in Opposite( Rows( Q ) )>

julia> # notice that source && range are indeed swapped compared to the above
        Display( Source( Opposite( sum ) ) )
A row module over Q of rank 2

julia> Display( Range( Opposite( sum ) ) )
A row module over Q of rank 1

```
